class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  include AASM

  belongs_to :user
  validates :title, presence: true

  # 讓story的ORM搜尋都吃到這個條件
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

  # 把destory方法覆寫成更新deleted_at欄位
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
