# _Library App_

##### _Become a patron, checkout and return books, 8/20/15_

#### By _**Kendra Ash | Shannon Mulloy**_

## Description

See, update and delete books and patrons. Checkout available books and return them.

## Setup

* _Clone from GitHub_
* _Set up databases: library and library_test2,
  with tables:
    books (book_id serial PRIMARY KEY, title varchar, author varchar)
    patrons (patron_id serial PRIMARY KEY, patron_name varchar)
    books_patrons (id serial PRIMARY KEY, book_id int, patron_id int, check_out_date timestamp, due_date timestamp, returned_date timestamp)_
* _Run bundle_
* _Open in Sintra_

## Technologies Used

_Ruby, Postgres_

### Legal

Copyright (c) 2015 **_Kendra Ash | Shannon Mulloy_**

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
