class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :book_lists, dependent: :destroy
  has_many :lists, through: :book_lists
  has_many :reviews

  def mean_rating(book)
    all_rating = 0.0
    book.reviews.each do |review|
      all_rating += review.rating
    end
    if book.reviews.count == 0
      0
    else
      (all_rating / book.reviews.count).round(1)
    end
  end
end
