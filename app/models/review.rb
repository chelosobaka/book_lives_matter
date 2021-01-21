class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  RATING = %w{1 2 3 4 5}
  scope :lately, lambda{where "updated_at >= ?", 2.days.ago}
end
