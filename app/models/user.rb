class User < ApplicationRecord # ok
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_type, on: :create
  has_one_attached :profile_photo

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  validates :type, presence: true, inclusion: { in: %w[AdminUser BuyerUser] }

  private

  def set_default_type
    self.type = "BuyerUser" if self.type.blank?
  end
end
