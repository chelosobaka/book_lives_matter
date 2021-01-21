class Author < ApplicationRecord
  has_and_belongs_to_many :books
  validates :name, uniqueness: true
  validates :name, presence: true
end