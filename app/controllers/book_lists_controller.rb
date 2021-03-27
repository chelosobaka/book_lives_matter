class BookListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_list, only: [:destroy]

  def create
    @book_list = BookList.new(book_list_params)
    list_name = current_user.lists.find(book_list_params[:list_id]).name
    if @book_list.save(book_list_params)
      flash[:notice] = "Книга добавлена в Ваш список \"#{list_name}\"."
      redirect_to request.referrer
    else
      flash[:alert] = @book_list.errors.full_messages.to_sentence
      redirect_to request.referrer
    end
  end

  def destroy
    list_id = @book_list.list_id
    @book_list.destroy
      redirect_to user_list_path(current_user.id, list_id), notice: 'Книга удалена из списка.'
    end
  end

  private
    def set_book_list
      @book_list = BookList.find(params[:id])
    end

    def book_list_params
      params.require(:book_list).permit(:id, :book_id, :list_id)
    end
end
