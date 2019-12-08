# frozen_string_literal: true
class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: [:"未着手", :"着手中", :"完了"]
  enum priority: [:"高", :"中", :"低"]
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  has_many :notices, dependent: :destroy
  has_many_attached :pdfs

  scope :name_search, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :status_search, ->(status) { where('status = ?', status) }
  scope :priority_search, ->(priority) { where('priority = ?', priority) }
  scope :sorting, -> { order(deadline: :desc) }
  scope :standard, -> { order(created_at: :desc) }
  scope :sorting_priority, -> { order(priority: :asc) }

  def start_time
    deadline
  end
end
