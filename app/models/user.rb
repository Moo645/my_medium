class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :stories, dependent: :destroy
  has_many :comment
  has_one_attached :avatar

  # Validations
  validates :username, presence: true, uniqueness: true


end
