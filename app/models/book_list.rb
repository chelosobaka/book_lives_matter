class BookList < ApplicationRecord
  belongs_to :book
  belongs_to :list
  accepts_nested_attributes_for :list
  validates_uniqueness_of :book_id, :scope => :list_id,
                        :message => "This book has already been added."
end
