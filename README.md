## Setup
###Databases
  Database: Library
    Tables:
      patrons (patron_name VARCHAR, patron_id SERIAL PRIMARY KEY)
      books (book_id SERIAL PRIMARY KEY, author VARCHAR, title VARCHAR)
    Join Table:
      books_patrons (id SERIAL PRIMARY KEY, check_out_date TIMESTAMP, due_date TIMESTAMP, patron_id INT,   book_id INT, returned_date TIMESTAM)



Test Database
  library_test2


  <h3>Check out a book:</h3>
  <form action="/patrons/<%= @patron.patron_id() %>" method="post">

    <input type="hidden" name="_method" value="patch">

    <label for="title">Title:</label>
    <input type="text" name="title" id="title">

    <button type="submit">Check out book!</button>
  </form>
