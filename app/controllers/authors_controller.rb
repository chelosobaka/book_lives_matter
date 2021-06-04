class AuthorsController < ApplicationController
  before_action :set_author

  def show
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.fetch(:author, {})
    end
end
