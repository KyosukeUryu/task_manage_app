class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  enum status: [:"未着手", :"着手中", :"完了"]
  enum priority: [:"高", :"中", :"低"]

  scope :both_search, -> (name, status){where('name LIKE ? AND status = ?', "%#{name}%", status )}
  scope :name_search, -> (name){where('name LIKE ?', "%#{name}%")}
  scope :status_search, -> (status){where('status = ?', status)}
  scope :sorting, -> {order(deadline: :desc)}
  scope :standard, -> {order(created_at: :desc)}
end
