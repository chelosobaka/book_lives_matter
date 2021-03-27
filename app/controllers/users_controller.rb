class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_user_id, only: [:followers, :subscriptions, :user_reviews, :subscriptions_reviews]

  def index
    if params[:search].present?
      @users = User.where("lower(username) LIKE ?", "%#{params[:search].downcase}%")
    else
      @users = User.all
    end
  end

  def show
    if @user == current_user
      subscriptions_reviews
      render "subscriptions_reviews"
    else
      user_reviews
      render "user_reviews"
    end
  end

  def followers
    @followers = @user.followers
  end

  def subscriptions
    @subscriptions = @user.subscriptions
  end

  def user_reviews
    @reviews = @user.reviews
  end

  def subscriptions_reviews
    @reviews = Review.where("user_id IN (?)", @user.subscriptions.ids).lately
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_user_id
    @user = User.find(params[:user_id])
  end

end
