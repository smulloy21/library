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
end
