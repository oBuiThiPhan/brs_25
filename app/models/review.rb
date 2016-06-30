class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy

  after_save :calculate_score

  validates :rating, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
    numericality: {greater_than: 0, less_than: 5}

  private
  def calculate_score
    sum = book.reviews.reduce(0) {|sum, element| sum + element.rating}
    average_score = sum / book.reviews.count
    book.update_attribute :rate_score, average_score
  end
end
