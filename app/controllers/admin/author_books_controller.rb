class AuthorBooksController < ApplicationController
  def create
    @author_book = AuthorBook.new(author_book_params)
    if @author_book.save
      flash[:notice] = "Автор добавлен к книге."
    else
      flash[:alert] = @author_book.errors.full_messages.to_sentence
    end
    redirect_to request.referrer
  end

  def destroy
    @author_book = AuthorBook.find(params[:id])
    if @author_book.destroy
      flash[:notice] = "Автор удалён из книги."
    else
      flash[:alert] = @author_book.errors.full_messages.to_sentence
    end
      redirect_to request.referrer
  end

  def author_book_params
    params.require(:author_book).permit(:id, :author_id, :book_id)
  end
end
