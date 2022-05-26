module StoryStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

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
  end

end