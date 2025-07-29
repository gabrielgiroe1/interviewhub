class TasksController < ApplicationController
  def index
    @tasks = Current.user&.tasks || Task.none
  end

  def new
    @task = Current.user.tasks.build
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new, alert: "Failed to create task."
    end
  end

  def edit
    @task = Current.user.tasks.find(params[:id])
  end

  def show
    @task = Current.user.tasks.find(params[:id])
  end

  def update
    @task = Current.user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit, alert: "Failed to update task."
    end
  end

  def destroy
    @task = Current.user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  private
  def task_params
    params.require(:task).permit(:title, :status, :due_date)
  end
end
