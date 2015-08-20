class Patron
  attr_reader(:patron_name, :patron_id)

  define_method(:initialize) do |attributes|
    @patron_name = attributes.fetch(:patron_name)
    @patron_id = attributes.fetch(:patron_id, nil)
  end

  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM patrons;")
    patrons = []
    result.each() do |patron|
      name = patron.fetch("patron_name")
      id = patron.fetch("patron_id").to_i()
      patrons.push(Patron.new({:patron_name => name, :patron_id => id}))
    end
    patrons
  end

  define_method(:==) do |other|
    self.patron_id == other.patron_id
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (patron_name) VALUES ('#{@patron_name}') RETURNING patron_id;")
    @patron_id = result.first().fetch('patron_id').to_i()
  end

  define_singleton_method(:find) do |id|
     Patron.all().each() do |patron|
       if patron.patron_id() == id
         return patron
       end
     end
  end

   define_method(:update) do |attributes|
     @patron_name = attributes.fetch(:patron_name, @patron_name)
     @id = self.patron_id()
     DB.exec("UPDATE patrons SET patron_name = '#{@patron_name}' WHERE patron_id = #{@id};")

     attributes.fetch(:book_ids, []).each() do |book_id|
       @check_out_date = Time.now()
       @due_date = Time.now + (60*60*24*7*2)
       DB.exec("INSERT INTO books_patrons(book_id, patron_id, check_out_date, due_date) VALUES (#{book_id}, #{self.patron_id()}, '#{@check_out_date}', '#{@due_date}');")
    end
  end

   define_method(:delete) do
     @id = self.patron_id()
     DB.exec("DELETE FROM patrons WHERE patron_id = #{@id};")
   end

   define_method(:books) do
     patron_books = []
     results = DB.exec("SELECT book_id FROM books_patrons WHERE patron_id = #{self.patron_id()};")
     
     results.each() do |result|
       book_id = result.fetch('book_id').to_i()
       book = DB.exec("SELECT * FROM books WHERE book_id = #{book_id};")
       title = book.first().fetch('title')
       author = book.first().fetch('author')
       patron_books.push(Book.new({:title => title, :author => author, :book_id => book_id}))
     end
     patron_books
  end

end
