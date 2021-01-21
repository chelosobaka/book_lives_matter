class ListsController < ApplicationController

  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :authenticate_user!, exept: [:index, :show]
  # GET /lists
  # GET /lists.json
  def index
    @lists = @user.lists
  end

  # GET /lists/1
  # GET /lists/1.json
  def show

  end

  # GET /lists/new
  def new
    @list = @user.lists.build
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = @user.lists.build(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to user_lists_path(@user.id), notice: 'List was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to user_lists_path(@user.id), notice: 'List was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = @user.lists.find(params[:id])
    @list.destroy
    respond_to do |format|
      format.html { redirect_to user_lists_url(@user.id), notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
