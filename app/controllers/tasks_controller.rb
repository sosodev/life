class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @task_lists = TaskList.all
    @tasks = filter_tasks
  end

  def show
  end

  def new
    @task = Task.new
    @task_lists = TaskList.all
    @parent_tasks = []
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      @task_lists = TaskList.all
      @parent_tasks = @task.task_list_id ? Task.where(task_list_id: @task.task_list_id) : []
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task_lists = TaskList.all
    @parent_tasks = @task.task_list_id ? Task.where(task_list_id: @task.task_list_id) : []
  end

  def update
    if params[:complete] == 'true'
      @task.update(finished_at: Time.current)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "tasks/task_item", locals: { task: @task, show_confetti: true }) }
        format.html { redirect_to tasks_path, notice: "Task completed." }
      end
      return
    end

    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task was successfully updated."
    else
      @task_lists = TaskList.all
      @parent_tasks = @task.task_list_id ? Task.where(task_list_id: @task.task_list_id) : []
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  def parent_tasks
    task_list_id = params[:task_list_id]

    if task_list_id.present?
      tasks = Task.where(task_list_id: task_list_id).select(:id, :name)
      render json: tasks
    else
      render json: []
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :task_list_id, :parent_id, :urgent, :important, :due_date, :scheduled_at, :estimate, :recur_after)
  end

  def filter_tasks
    tasks = Task.includes(:task_list, :parent, children: [ :task_list, :parent, :children ])

    # Filter by task list if specified
    if params[:task_list_id].present?
      tasks = tasks.where(task_list_id: params[:task_list_id])
    end

    # Filter by urgent if specified
    if params[:urgent] == "true"
      tasks = tasks.where(urgent: true)
    end

    # Filter by important if specified
    if params[:important] == "true"
      tasks = tasks.where(important: true)
    end

    # Filter by due date if specified
    case params[:due_date]
    when "overdue"
      tasks = tasks.where("due_date < ?", Date.current)
    when "today"
      tasks = tasks.where(due_date: Date.current)
    when "this_week"
      tasks = tasks.where(due_date: Date.current..Date.current.end_of_week)
    when "no_due_date"
      tasks = tasks.where(due_date: nil)
    end

    # Filter by completion status
    case params[:completed]
    when "completed"
      tasks = tasks.where.not(finished_at: nil)
    when "not_completed"
      tasks = tasks.where(finished_at: nil)
    end

    # Only show top-level tasks (children will be shown via expansion)
    tasks.where(parent_id: nil).order(:created_at)
  end
end
