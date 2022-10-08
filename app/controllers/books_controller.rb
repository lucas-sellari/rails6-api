class BooksController < ApplicationController
  # BooksController inherits from ApplicationController
  def index #action
    render json: Book.all # Book: active record MODEL
  end
end
