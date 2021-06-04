class Admin::AuthorsController < Admin::AdminController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
     if params[:search].present?
      @authors = Author.where("lower(name) LIKE ?",
      "%#{params[:search].downcase}%").page(params[:page]).per(20)
    else
      @authors = Author.all.page(params[:page]).per(20)
    end
  end

  def show
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)
      if @author.save
        redirect_to admin_authors_path, notice: 'Автор успешно создан.'
      else
        render :new
      end
  end

  def update
    if @author.update(author_params)
      redirect_to admin_authors_path, notice: 'Автор успешно обновлён.'
    else
      render :edit
    end
  end

  def destroy
    if @author.destroy
      redirect_to admin_authors_url, notice: 'автор удалён.'
    end
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name)
    end
end
