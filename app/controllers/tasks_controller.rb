class TasksController < ApplicationController
  def index
    @task_lists = TaskList.all
    @tasks = filter_tasks
  end

  def show
  end

  def new
    @task = Task.new
    @task_lists = TaskList.all
    @parent_tasks = Task.where(parent_id: nil)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      @task_lists = TaskList.all
      @parent_tasks = Task.where(parent_id: nil)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :task_list_id, :parent_id, :urgent, :important, :due_date, :estimate, :recur_after)
  end

  def filter_tasks
    tasks = Task.includes(:task_list, :parent)

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

    # Only show top-level tasks (children will be shown via expansion)
    tasks.where(parent_id: nil).order(:created_at)
  end
end
