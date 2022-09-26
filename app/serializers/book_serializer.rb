class BookSerializer
  include JSONAPI::Serializer
  set_type :books
  attributes :id, 
             :destination, 
             :forecast, 
             :total_books_found, 
             :books
end