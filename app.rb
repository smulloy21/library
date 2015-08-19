require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books/new') do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.new({:title => title, :author => author})
  @book.save()
  redirect('/books')
end

get('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i())
  erb(:book)
end

patch('/books/:id') do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.find(params.fetch('id').to_i())
  @book.update({:title => title, :author => author})
  redirect('/books')
end
