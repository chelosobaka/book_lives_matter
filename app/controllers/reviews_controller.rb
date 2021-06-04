class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_book

  def index
    @reviews = @book.reviews
  end

  def new
    @review = @book.reviews.build
  end

  def edit

  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.book = @book
    if @review.save
      redirect_to @book, notice: 'Отзыв опубликован.'
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      redirect_to book_path(@book.id), notice: 'Отзыв обновлён.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book.id), notice: 'Отзыв удалён.'
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def review_params
      params.require(:review).permit(:body, :rating, :user_id, :book_id)
    end
end
