require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test2'})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/patrons') do
    @patrons = Patron.all()
    erb(:patrons)
end

post('/books/new') do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.new({:title => title, :author => author})
  @book.save()
  redirect('/books')
end

post('/patrons/new') do
  name = params.fetch('patron_name')
  @patron = Patron.new({:patron_name => name})
  @patron.save()
  redirect('/patrons')
end

get('/patrons/:id') do
  @patron = Patron.find(params.fetch('id').to_i())
  erb(:patron)
end

get('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i())
  erb(:book_edit)
end

get('/patrons/:id/edit') do
  @patron = Patron.find(params.fetch('id').to_i())
  erb(:patron_edit)
end

patch('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i())
  if params.fetch('title').length > 0
    @book.update({:title => params.fetch('title')})
  end
  if params.fetch('author').length > 0
    @book.update({:author => params.fetch('author')})
  end
  redirect('/books/' + @book.book_id().to_s())
end

get('/books/:id') do
    @book = Book.find(params.fetch('id').to_i())
    erb(:book)
end

delete('/books/:id') do
  @book = Book.find(params.fetch('id').to_i())
  @book.delete()
  redirect('/books')
end

patch('/patrons/:id/edit') do
  patron = params.fetch('patron_name')
  @patron = Patron.find(params.fetch('id').to_i())
  @patron.update({:patron_name => patron})
  redirect('/patrons/' + @patron.patron_id().to_s())
end

patch('/patrons/:id') do
  @patron = Patron.find(params.fetch('id').to_i())
  title = params.fetch('title')
  @book = Book.find_by_title(title)
  @patron.update({:book_ids => [@book.book_id()]})
  redirect('/patrons/' + @patron.patron_id().to_s())
end

delete('/patrons/:id') do
  @patron = Patron.find(params.fetch('id').to_i())
  @patron.delete()
  redirect('/patrons')
end
