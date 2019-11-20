class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
end
