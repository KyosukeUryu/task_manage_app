class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  enum status: [:not_ready, :ready, :done]

  # def self.search(search)
  #   if search
  #     where(['name LIKE ?', "%#{search}%"])
  #   else
  #     all
  #   end
  # end
end
