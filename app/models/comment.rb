class Comment < ApplicationRecord
  # Gems settings
  acts_as_paranoid

  # Relationships
  belongs_to :user
  belongs_to :story

end
