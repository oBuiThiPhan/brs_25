class Mark < ActiveRecord::Base
  include ActivityLog
  enum mark_type: [:reading, :read, :favorite]
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  scope :reading, ->{
    joins(:user).where mark_type: Settings.mark.mark_type.reading}
  scope :read, ->{
    joins(:user).where mark_type: Settings.mark.mark_type.read}

  after_save :create_mark_activity

  private
  def create_mark_activity
    create_activity user_id, book_id, Activity.target_types[:book_target],
      Activity.action_types[mark_type]
  end
end
