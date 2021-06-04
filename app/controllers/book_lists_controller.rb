class BookListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book_list = BookList.new(book_list_params)
    list_name = current_user.lists.find(book_list_params[:list_id]).name
    if @book_list.save(book_list_params)
      flash[:notice] = "Книга добавлена в Ваш список \"#{list_name}\"."
    else
      flash[:alert] = @book_list.errors.full_messages.to_sentence
    end
    redirect_to request.referrer
  end

  def destroy
    @book_list = BookList.find(params[:id])
    list_id = @book_list.list_id
    if @book_list.destroy
      redirect_to user_list_path(current_user.id, list_id), notice: 'Книга удалена из списка.'
    end
  end

  private

    def book_list_params
      params.require(:book_list).permit(:id, :book_id, :list_id)
    end
end
