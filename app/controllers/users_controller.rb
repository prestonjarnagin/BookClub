class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.find_reviews_by_user_id(params[:id])
    if params[:sorting] == 'recency'
      @reviews = Review.find_reviews_by_user_id(params[:id], params[:direction])
    end
  end
end
