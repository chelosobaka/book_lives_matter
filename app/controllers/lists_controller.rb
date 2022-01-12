class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @lists = @user.lists
  end

  def show

  end

  def new
    @list = @user.lists.build
  end

  def edit
  end

  def create
    @list = @user.lists.build(list_params)
    if @list.save
      redirect_to user_lists_path(@user.id), notice: 'Список создан.'
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      redirect_to user_lists_path(@user.id), notice: 'Список редактирован.'
    else
      render :edit
    end
  end

  def destroy
    @list = @user.lists.find(params[:id])
    @list.destroy
    redirect_to user_lists_url(@user.id), notice: 'Список удалён.'
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
