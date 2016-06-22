class User < ActiveRecord::Base
  has_many :user_books
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :like_activities, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  before_save {email.downcase}

  has_secure_password

end
