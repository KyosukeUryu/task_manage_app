# frozen_string_literal: true
class JoinsController < ApplicationController
  def create
    current_user.joins.create(group_id: params[:group_id])
    redirect_to groups_path, notice: 'グループに参加しました!'
  end

  def destroy
    if Join.find_by(id: params[:id]).group.owner_id == current_user.id
      redirect_to groups_path, notice: 'オーナーは退会出来ません'
    else
      current_user.joins.find_by(id: params[:id]).destroy
      redirect_to groups_path, notice: 'グループから外れました'
    end
  end
end
