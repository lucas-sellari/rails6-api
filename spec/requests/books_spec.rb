require "rails_helper" # for every spec

describe "Books API", type: :request do #contains all the tests  for the book api
  it "returns all books" do #it block for specific test
    FactoryBot.create(:book, title: "1984", author: "George Orwell")
    FactoryBot.create(:book, title: "Harry Potter", author: "J.K. Rowling")

    get "/api/v1/books"

    expect(response).to have_http_status(:success) #200, but it does not check if there are any books being returned
    expect(JSON.parse(response.body).size).to eq(2)
  end
end