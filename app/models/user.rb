class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :stories, dependent: :destroy
  has_many :follows
  has_many :bookmarks
  has_one_attached :avatar

  # Validations
  validates :username, presence: true, uniqueness: true

  # instance method
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy!
      return 'follow'
    else
      follows.create(following: user)
      return 'followed'
    end
  end

  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return 'unbookmark'
    else
      bookmarks.create(story: story)
      return 'bookmarked'
    end
  end

end
