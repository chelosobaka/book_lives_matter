class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @books = Book.joins(:authors).where("lower(title) LIKE ? OR lower(authors.name) LIKE ?",
      "%#{params[:search].downcase}%",
      "%#{params[:search].downcase}%").page(params[:page]).per(18)
    else
      @books = Book.all.page(params[:page]).per(18)
    end
  end

  def show
    @reviews = @book.reviews
    @review = Review.new
    @book_list = BookList.new
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end

  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end



  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, {author_ids:[]}, :series, :lb_id, :isbn, :poster)
    end
end
