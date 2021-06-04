class AuthorBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

  accepts_nested_attributes_for :author
  validates_uniqueness_of :author_id, scope: :book_id

end
