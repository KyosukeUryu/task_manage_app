# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :recommend_login
  def index
    @tasks = current_user.tasks.standard.page(params[:page]).per(10)
    sort_click
    task_search_click
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: 'タスクが作成できました'
    else
      render :new
    end
  end

  def show
    if @task.user_id != current_user.id && current_user.notices.find_by(task_id: params[:id]).blank?
      current_user.notices.create(task_id: params[:id])
    end
  end

  def edit; end

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
    params.require(:task).permit(:name, :description, :deadline, :status, :priority, { label_ids: [] }, pdfs: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_click
    if params[:sort_expired]
      @tasks = current_user.tasks.sorting.page(params[:page]).per(10)
    end
    if params[:sort_priority]
      @tasks = current_user.tasks.sorting_priority.page(params[:page]).per(10)
    end
  end

  def task_search_click
    if params[:task]
      @tasks = @tasks.name_search(params[:task][:name]).page(params[:page]).per(10)
      if params[:task][:status].present?
        @tasks = @tasks.status_search(params[:task][:status]).page(params[:page]).per(10)
      end
      if params[:task][:priority].present?
        @tasks = @tasks.priority_search(params[:task][:priority]).page(params[:page]).per(10)
      end
      if params[:task][:labels_id].present?
        @labellings = Labelling.where('label_id = ?', params[:task][:labels_id])
        @labelled_tasks_id = @labellings.pluck(:task_id)
        @tasks = @tasks.where(id: @labelled_tasks_id)
      end
    end
  end
end
