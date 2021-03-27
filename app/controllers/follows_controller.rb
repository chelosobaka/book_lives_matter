class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:follower_id])
    redirect_to request.referrer
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_to request.referrer
  end
end

