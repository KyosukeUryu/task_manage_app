class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :groups, through: :joins
  has_many :groups, foreign_key: :owner_id

  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :update, allow_blank: true

  before_destroy do
    if User.where(admin: true).count == 1 && self.admin?
      throw(:abort)
    end
  end
end
