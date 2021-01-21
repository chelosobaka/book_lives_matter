module AuthorsHelper
  def book_link(author)
    books = author.books.map{|book| link_to "#{book.title.gsub(/[^\w]*:/, "").lstrip}", book_path(book)}
    books.join(", ").html_safe
  end
end
