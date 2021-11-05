class List < ApplicationRecord
  belongs_to :user
  has_many :book_lists, dependent: :destroy
  has_many :books, through: :book_lists

  validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates_uniqueness_of :name, scope: :user
  validates :user, presence: true

end
