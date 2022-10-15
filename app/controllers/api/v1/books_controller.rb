module Api
  module V1

    class BooksController < ApplicationController
      MAX_PAGINATION_LIMIT = 100
      # BooksController inherits from ApplicationController

      # rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

      def index #action
        # render json: Book.all # Book: active record MODEL
        books = Book.limit(limit).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_json
      end

      def create #POST
        author = Author.create!(author_params)
        # Book.create(title: "...", author: "...") create a Book in DB, but it does not handle the cases of work and does not work...
        # book = Book.new(title: params[:title], author: params[:author]) #initialzie the record, but not save to DB
        # binding.irb # rails built in breakpoint

        book = Book.new(book_params.merge(author_id: author.id))

        if book.save # all rails validations on Book model get called
          render json: BookRepresenter.new(book).as_json, status: :created #201
        else
          render json: book.errors, status: :unprocessable_entity #422
        end
      end

      def destroy
        Book.find(params[:id]).destroy! # record not destroyed can be raised

        head :no_content #204 in the head of the response

      # it has some disadvantages to write in this way
      # rescue ActiveRecord::RecordNotDestroyed
      #   render json: {}, status: :unprocessable_entity
      end

      private
      # required params
      def book_params
        params.required(:book).permit(:title)
      end

      def author_params
        params.required(:author).permit(:first_name, :last_name, :age)
      end

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, #default is 100
          MAX_PAGINATION_LIMIT
        ].min
      end

      # def not_destroyed
      #   render json: {}, status: :unprocessable_entity
      # end

    end

  end
end