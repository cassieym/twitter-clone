class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

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
end
