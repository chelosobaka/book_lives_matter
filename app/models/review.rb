class Review < ApplicationRecord
  RATING = [1, 2, 3, 4, 5]
  belongs_to :user
  belongs_to :book

  validates :body, :user, presence: true
  validates :body, length: {minimum: 10, maximum: 4000}
  validates :rating, presence: true, inclusion: {in: RATING}

  scope :lately, lambda{where "updated_at >= ?", 2.days.ago}
end
