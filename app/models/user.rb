class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_one_attached :avatar  # hooks into Active Storage so each user can have profile picture

  validates :email_address, uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A\w{1,20}\z/, message: "only letters, numbers, underscores (max 20)" }
  validates :display_name, length: { maximum: 50 }
  validates :bio, length: { maximum: 160 }

  def to_param  # generates /users/username instead of users/1
    username
  end

  def feed_tweets
    Tweet.where(user_id: [ id ] + following.pluck(:id)).order(created_at: :desc)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def liked?(tweet)
    liked_tweets.include?(tweet)
  end
end
