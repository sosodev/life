class TaskListsController < ApplicationController
  def index
    @task_lists = TaskList.all
  end

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = TaskList.new(task_list_params)
    
    if @task_list.save
      redirect_to task_lists_path, notice: 'Task list was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])
    
    if @task_list.update(task_list_params)
      redirect_to task_lists_path, notice: 'Task list was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_list = TaskList.find(params[:id])
    @task_list.destroy
    redirect_to task_lists_path, notice: 'Task list was successfully deleted.'
  end

  private

  def task_list_params
    params.require(:task_list).permit(:name)
  end
end
