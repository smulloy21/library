class Book

  attr_reader(:title, :author, :book_id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @book_id = attributes.fetch(:book_id, nil)
  end

  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM books;")
    books = []
    result.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      book_id = book.fetch("book_id").to_i()
      books.push(Book.new({:title => title, :author => author, :book_id => book_id}))
    end
    books
  end

  define_method(:==) do |other|
    self.book_id == other.book_id
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING book_id;")
    @book_id = result.first().fetch('book_id').to_i()
    # binding.pry

  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.book_id() == id
        found_book = book
      end
    end
    found_book
  end

  define_singleton_method(:find_by_title) do |title_to_find|
    found_book = nil
    Book.all().each() do |book|
      if book.title() == title_to_find
        found_book = book
      end
    end
    found_book
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @id = self.book_id()
    DB.exec("UPDATE books SET title = '#{@title}', author = '#{@author}' WHERE book_id = #{@id};")

    attributes.fetch(:patron_ids, []).each() do |patron_id|
      @check_out_date = Time.now()
      @due_date = Time.now + (60*60*24*7*2)
      DB.exec("INSERT INTO books_patrons (book_id, patron_id, check_out_date, due_date) VALUES (#{self.book_id}, #{patron_id}, '#{@check_out_date}', '#{@due_date}');")
    end
  end

  define_method(:delete) do
    @id = self.book_id()
    DB.exec("DELETE FROM books WHERE book_id = #{@id};")
  end

  define_method(:patrons) do
    returned_patrons = []
    results = DB.exec("SELECT * FROM books_patrons WHERE book_id = #{self.book_id}")

    results.each() do |result|
      patron_id = result.fetch('patron_id').to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE patron_id = #{patron_id}")
      name = patron.first().fetch('patron_name')
      returned_patrons.push(Patron.new({:patron_name => name, :patron_id => patron_id}))
    end
    returned_patrons
  end
end
