class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def destroy
    BookAuthor.where(author_id: params[:id]).destroy_all
    Author.destroy(params[:id])
    redirect_to books_path
  end
end
