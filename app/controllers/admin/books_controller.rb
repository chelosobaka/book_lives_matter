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

    def author_params
      params.require(:book).permit(:title, :series, :lb_id, :isbn, :poster, author_books_attributes: [author_attributes: [:name]])
    end
end
