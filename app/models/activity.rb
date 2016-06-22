class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :like_activities, dependent: :destroy
end
