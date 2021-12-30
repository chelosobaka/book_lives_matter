class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    if params[:search].present?
      @books = Book.left_joins(:authors).where("lower(books.title) LIKE ? OR lower(authors.name) LIKE ?",
      "%#{params[:search].downcase}%",
      "%#{params[:search].downcase}%").page(params[:page]).per(15)
    else
      @books = Book.all.page(params[:page]).per(15)
    end
  end

  def show
    @reviews = @book.reviews
    @review = Review.new
    @book_list = BookList.new
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, {author_ids:[]}, :series, :lb_id, :isbn, :poster)
    end
end
