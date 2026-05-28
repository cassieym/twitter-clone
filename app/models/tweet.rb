class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Tweet", optional: true, counter_cache: :replies_count
  has_many :replies, class_name: "Tweet", foreign_key: :parent_id, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  scope :root_tweets, -> { where(parent_id: nil) }
  scope :recent, -> { order(created_at: :desc) }

  def ancestors
    chain = []
    node = parent
    while node && chain.length < 20
      chain.unshift(node)
      node = node.parent
    end
    chain
  end
end
