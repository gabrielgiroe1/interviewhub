class TasksController < ApplicationController
  allow_unauthenticated_access only: %i[new create edit update delete]
  def index
    @tasks = Task.all
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @tasks = current_user.tasks.build(task_params)
    if @tasks.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new, alert: "Failed to create task."
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      render :edit, alert: "Failed to update task."
    end
  end

  def delete
    @task = current_user.tasks.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: "Task deleted successfully."
    else
      redirect_to tasks_path, alert: "Failed to delete task."
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :status, :due_date)
  end
end
