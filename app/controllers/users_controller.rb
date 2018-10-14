class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = Review.find_reviews_by_user_id(params[:id])
  end
end
