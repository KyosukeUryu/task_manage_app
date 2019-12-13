# frozen_string_literal: true

class LabelsController < ApplicationController
  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to root_path, notice: 'ラベルを登録しました'
    else
      render :new
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
