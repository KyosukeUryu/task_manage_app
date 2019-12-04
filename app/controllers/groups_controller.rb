class GroupsController < ApplicationController
  def index
    @groups = Group.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end



  private

  def group_params
    params.require(:group).permit(:name)
  end



end
