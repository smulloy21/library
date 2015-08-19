require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('path for viewing all books', {:type => :feature}) do
  it('the book path to view all books') do
    visit('/')
    click_on('View all books')
    expect(page).to have_content('Books in the Library:')
  end
end

describe('path for adding a book', {:type => :feature}) do
  it('will add a book to the database') do
    visit('/books')
    fill_in('title', :with => 'Maze Runner')
    fill_in('author', :with => 'Mike')
    click_button('Add book')
    expect(page).to have_content('Maze Runner By: Mike')
  end
end
