class GroupsController < ApplicationController
  before_action :set_groups, only: %i[show edit update destroy]
  before_action :owner_only, only: %i[edit update destroy]

  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'グループを削除しました'
  end


  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_groups
    @group = Group.find(params[:id])
  end

  def owner_only
    if current_user.id != @group.owner_id
      redirect_to group_path
    end
  end

end
