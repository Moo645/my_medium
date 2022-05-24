class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stories
  validates :username, presence: true, uniqueness: true

  has_one_attached :avatar do |attachable|
    attachable.variant :profile_avatar, resize_to_limit: [200, 200]
    attachable.variant :navbar_avatar, resize_to_limit: [50, 50]
  end

end
