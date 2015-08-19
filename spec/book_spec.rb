require('spec_helper')

describe(Book) do
  describe('#title') do
    it("return the title of the book") do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      expect(test.title()).to(eq('The Captains Daughter'))
    end
  end

  describe('.all') do
    it('return an empty array at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('returns equal when two books have the same id') do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test2 = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      expect(test).to(eq(test2))
    end
  end

  describe('#save') do
    it('saves an instance of book to the database') do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test.save()
      expect(Book.all()).to(eq([test]))
    end
  end

  describe('.find') do
    it('return a book that matches the id') do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test.save()
      expect(Book.find(test.book_id)).to(eq(test))
    end
  end
end
