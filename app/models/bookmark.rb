class Bookmark < ApplicationRecord
    # Relationships
    belongs_to :user
    belongs_to :story
  end
  