class Review < ApplicationRecord
  RATING = [1, 2, 3, 4, 5]
  belongs_to :user
  belongs_to :book

  validates :body, :user, presence: true
  validates :body, length: {minimum: 10, maximum: 4000}
  validates :rating, presence: true, inclusion: {in: RATING}

  scope :lately, lambda{where "updated_at >= ?", 2.days.ago}

  def self.fake_review
    User.all.ids.each do |bl_user_id|
      Book.all.ids.sample(10).each do |bl_book_id|
        Review.create(book_id: bl_book_id, user_id: bl_user_id,
           rating: Review::RATING.sample, body: Faker::Quote.matz)
      end
    end
  end
end
