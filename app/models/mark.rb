class Mark < ActiveRecord::Base
  enum mark_type: {reading: 0, read: 1}

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
end
