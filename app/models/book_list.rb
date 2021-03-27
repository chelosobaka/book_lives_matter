class BookList < ApplicationRecord
  belongs_to :book
  belongs_to :list
  validates_uniqueness_of :book_id, :scope => :list_id,
                        :message => "Эта книга уже добавлена в список."
end
