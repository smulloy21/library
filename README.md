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
