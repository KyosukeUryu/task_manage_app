class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  def index
    if params[:sort_expired].present?
      @tasks = Task.order(deadline: :desc)
    elsif params[:task].blank?
      @tasks = Task.order(created_at: :desc)
    else
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = Task.where('name LIKE ? AND status = ?', "%#{params[:task][:name]}%", params[:task][:status] )
      elsif params[:task][:name].present?
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%")
      else
        @tasks = Task.where('status = ?', params[:task][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが作成できました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクを更新しました'
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # def integer_string?(str)
  #   Integer(str)
  #   true
  # rescue ArgumentError
  #   false
  # end


end
