class JoinsController < ApplicationController
  def create
    join = current_user.joins.create(group_id: params[:group_id])
    redirect_to groups_path, notice: 'グループに参加しました!'
  end

  def destroy
    join = current_user.joins.find_by(id: params[:id]).destroy
    redirect_to groups_path, notice: 'グループから外れました'
  end
end
