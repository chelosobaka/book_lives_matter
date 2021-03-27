class List < ApplicationRecord
  belongs_to :user
  has_many :book_lists, dependent: :destroy
  has_many :books, through: :book_lists

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 30}
  validates :user, presence: true

end
