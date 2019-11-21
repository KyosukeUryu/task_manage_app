class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  enum status: [:"未着手", :"着手中", :"完了"]

  # def self.search(search)
  #   if search
  #     where(['name LIKE ?', "%#{search}%"])
  #   else
  #     all
  #   end
  # end
end
