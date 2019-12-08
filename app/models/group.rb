# frozen_string_literal: true
class Group < ApplicationRecord
  validates :name, presence: true

  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
  belongs_to :user, class_name: "User", foreign_key: :owner_id
end
