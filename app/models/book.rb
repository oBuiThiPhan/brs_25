class Book < ActiveRecord::Base
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  mount_uploader :image, BookImageUploader

  validates :title, presence: true, length: {maximum: 50}
  validates :author, presence: true, length: {maximum: 50}
  validates :number_of_pages, presence: true
  validates :publish_date, presence: true
end
