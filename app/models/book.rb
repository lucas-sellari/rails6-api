class Book < ApplicationRecord
  # ORM layer which maps book to a DB table with the active records methods...
  validates :author, presence: true, length: { minimum: 3 } #validate field symbol with the function
  validates :title, presence: true, length: { minimum: 3 }
end
