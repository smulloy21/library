class Book

  attr_reader(:title, :author, :book_id, :patron_id, :check_out_date, :due_date)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @book_id = attributes.fetch(:book_id, nil)
    @patron_id = attributes.fetch(:patron_id, nil)
    @check_out_date = attributes.fetch(:check_out_date, nil)
    @due_date = attributes.fetch(:due_date, nil)

  end

  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM books;")
    books = []
    result.each() do |book|
      title = book.fetch("title")
      author = book.fetch("author")
      book_id = book.fetch("book_id")
      patron_id = book.fetch("patron_id")
      check_out_date = book.fetch("check_out_date")
      due_date = book.fetch("due_date")
      books.push(Book.new({:title => title, :author => author, :book_id => book_id, :patron_id => patron_id, :check_out_date => check_out_date, :due_date => due_date}))
    end
    books
  end

  define_method(:==) do |other|
    self.book_id == other.book_id
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING book_id;")
    @book_id = result.first().fetch('book_id')
    @book_id.to_i()
  end

  define_singleton_method(:find) do |id|
    Book.all().each() do |book|
      if book.book_id() == id
        return book
      end
    end
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @id = self.book_id()
    DB.exec("UPDATE books SET title = '#{@title}', author = '#{@author}' WHERE patron_id = #{@id};")
  end

  define_method(:delete) do
    @id = self.book_id()
    DB.exec("DELETE FROM books WHERE book_id = #{@id};")
  end

end
