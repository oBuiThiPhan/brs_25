class Mark < ActiveRecord::Base
  enum mark_type: [:reading, :read, :favorite]

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  scope :reading, ->{
    joins(:user).where mark_type: Settings.mark.mark_type.reading}
  scope :read, ->{
    joins(:user).where mark_type: Settings.mark.mark_type.read}
end
