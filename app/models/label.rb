class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings
  belongs_to :user, optional: true
  validates :name, presence: true, length: { maximum: 10 } 
end
