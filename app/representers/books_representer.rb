class BooksRepresenter
  def initialize(books)
    # assign the param to an instance variable to access it inside the class
    @books = books
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        author_name: author_name(book),
        author_age: book.author.age
      }
    end
  end

  private

  attr_reader :books #allow us to access the books via the books method, only available inside the class

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end
end