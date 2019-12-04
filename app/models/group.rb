class Group < ApplicationRecord
  validates :name, presence: true

  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
end
