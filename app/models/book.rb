class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :book_lists, dependent: :destroy
  has_many :lists, through: :book_lists
  has_many :reviews, dependent: :destroy


  def mean_rating(book)
    if book.reviews.count == 0
      0
    else
      all_rating = book.reviews.average(:rating).round(1)
    end
  end


  def self.create_all
    path = Dir.glob('db/labirint.json').first
    file = File.read(path)
    data = JSON.load(file)
    data.each do |h|
      unless h["authors"].nil?
        h["authors"].each do |author|
          Author.create(name: author)
        end
      end
      book = Book.new(title: h["title"], series: h["series"], lb_id: h["lb_id"], isbn: h["isbn"], poster: h["poster"])
      unless h["authors"].nil?
        h["authors"].each do |author|
          book.authors << Author.find_by(name: author)
        end
      end
      book.save
    end
  end
end
