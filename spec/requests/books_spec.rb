require "rails_helper" # for every spec

describe "Books API", type: :request do #contains all the tests  for the book api
  describe "GET /books" do
    before do # it runs before every test inside this describe block
      FactoryBot.create(:book, title: "1984", author: "George Orwell")
      FactoryBot.create(:book, title: "Harry Potter", author: "J.K. Rowling")
    end

    it "returns all books" do #it block for specific test
      get "/api/v1/books"

      expect(response).to have_http_status(:success) #200, but it does not check if there are any books being returned
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /books" do
    it "creates a new book" do
      # rspec method to check if the DB count changes
      expect {
        post "/api/v1/books", params: { book: { title: "The Martian", author: "Andy Weir" } }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /books/:id" do
    let!(:book) { FactoryBot.create(:book, title: "1984", author: "George Orwell") } # from rspec, it is lazy loaded, only get called when we use book.id, unless we use !
    it "deletes a book" do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end