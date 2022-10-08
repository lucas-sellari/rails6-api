class BooksController < ApplicationController
  # BooksController inherits from ApplicationController
  def index #action
    render json: Book.all # Book: active record MODEL
  end

  def create #POST
    # Book.create(title: "...", author: "...") create a Book in DB, but it does not handle the cases of work and does not work...
    # book = Book.new(title: params[:title], author: params[:author]) #initialzie the record, but not save to DB

    book = Book.new(book_params)

    if book.save
      render json: book, status: :created #201
    else
      render json: book.errors, status: :unprocessable_entity #422
    end
  end

  private
  # required params
  def book_params
    params.required(:book).permit(:title, :author)
  end

end
