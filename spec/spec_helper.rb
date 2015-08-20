require('rspec')
require('book')
require('patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test2'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")

  end
end
