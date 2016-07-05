class Book < ActiveRecord::Base
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  mount_uploader :image, BookImageUploader

  validates :title, presence: true, length: {maximum: 50}
  validates :author, presence: true, length: {maximum: 50}
  validates :number_of_pages, presence: true
  validates :publish_date, presence: true

  Mark.mark_types.keys.each do |name|
    scope :"#{name}_books",
    ->(user){where(id: Mark.send(name).where(user_id: user.id).pluck(:book_id))}
  end

  def self.search(search, rate)
    if search.present? && rate.present?
      joins(:category).where("(books.title LIKE :getsearch
        OR books.author LIKE :getsearch
        OR categories.title LIKE :getsearch)
        AND (books.rate_score >= :rate AND books.rate_score < :rate1)",
        getsearch: "%#{search}%", rate: rate, rate1: (rate.to_i + 1))
    elsif search.present? || rate.present?
      if search.blank?
        where("rate_score >= ? AND rate_score < ?", rate, (rate.to_i + 1))
      else
        joins(:category).where("books.title LIKE :getsearch
          OR books.author LIKE :getsearch
          OR categories.title LIKE :getsearch",
          getsearch: "%#{search}%")
      end
    else
      all
    end
  end

end
