class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
  validates :name, uniqueness: true
  validates :name, presence: true
end
