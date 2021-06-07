class Admin::BooksController < Admin::AdminController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
     if params[:search].present?
      @books = Book.where("lower(title) LIKE ?",
      "%#{params[:search].downcase}%").page(params[:page]).per(20)
    else
      @books = Book.all.page(params[:page]).per(20)
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    book = Book.new(book_params["title"], book_params["series"], book_params["lb_id"], book_params["isbn"], book_params["poster"])
    if book_params["author_books_attributes"].present?
      book_params["author_books_attributes"].each do |author_books|
        author = Author.find_or_create_by(author_books[1]["author_attributes"]["name"])
        author_book = AuthorBook.new(author_id: author.id, book_id: book.id)
        if book.save && author_book.save
          redirect_to admin_books_path, notice: 'Книга успешно создана.'
        else
          render :new
        end
      end
    end

    if book.save
      redirect_to admin_books_path, notice: 'Книга успешно создана.'
    else
      render :new
    end
=begin
    @book = Book.new(book_params)
      if @book.save
        redirect_to admin_books_path, notice: 'Книга успешно создана.'
      else
        render :new
      end
=end
  end

  def update
    if @book.update(book_params)
      redirect_to admin_books_path, notice: 'Книга успешно обновлёна.'
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      redirect_to admin_books_url, notice: 'Книга удалён.'
    end
  end

  private
    def set_author
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :series, :lb_id, :isbn, :poster, author_books_attributes: [author_attributes: [:name]])
    end
end
