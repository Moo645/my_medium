class Story < ApplicationRecord
  include AASM

  belongs_to :user
  validates :title, presence: true
  default_scope { where(deleted_at: nil) }

  aasm column: 'status', no_direct_assignment: true do
    state :draft, initial: true
    state :published, :deleted

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end

    event :delete do
      transitions from: [:draft, :published], to: :deleted
    end
  end

  def destroy
    update(deleted_at: Time.now)
  end

end
