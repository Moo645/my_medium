class Story < ApplicationRecord
  include StoryStateMachine
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  # Relationships
  belongs_to :user

  # validations
  validates :title, presence: true

  # Scopes
  default_scope { where(deleted_at: nil) }

  # instance methods
  def destroy
    update(deleted_at: Time.now)
  end

  # babosa init / Using Babosa With FriendlyId 4+
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private

  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0..7]]
    ]
  end


end
