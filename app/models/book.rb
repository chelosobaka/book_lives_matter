class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :book_lists, dependent: :destroy
  has_many :lists, through: :book_lists
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :author_books

  before_save :find_or_create_authors
  validates :title, presence: true
  validates :isbn, uniqueness: true
  validates :lb_id, uniqueness: true

  def find_or_create_authors
    self.author_books.each do |author_book|
      author_book.author = Author.find_or_create_by(name: author_book.author.name)
    end
  end

  def average_rating
    if self.reviews.count == 0
      0
    else
      all_rating = self.reviews.average(:rating).round(1)
    end
  end


  def self.create_all(limit)
    path = Dir.glob('db/labirint.json').first
    file = File.read(path)
    data = JSON.load(file)
    data.take(limit).each do |h|
      unless h["authors"].nil?
        h["authors"].each do |author|
          Author.create(name: author)
          puts "#{author} - author created"
        end
      end
      book = Book.new(title: h["title"], series: h["series"], lb_id: h["lb_id"], isbn: h["isbn"], poster: h["poster"])
      unless h["authors"].nil?
        h["authors"].each do |author|
          book.authors << Author.find_by(name: author)
          puts "author #{author} add to book #{h["title"]}"
        end
      end
      book.save
      puts "book #{h["title"]} created"
    end
  end
end
