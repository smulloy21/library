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

  describe('#update') do
    it("updates a books name that matches the id") do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test.save()
      test.update({:author => 'A.S. Pushkin'})
      expect(test.author()).to(eq('A.S. Pushkin'))
    end
    it("updates both title and author") do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test.save()
      test.update({:title => 'Captains Daughter', :author => 'A.S. Pushkin'})
      expect(test.author()).to(eq('A.S. Pushkin'))
      expect(test.title()).to(eq('Captains Daughter'))
    end

    it('lets you add a paton to a book') do
      test_patron1 = Patron.new({:patron_name => 'Susan'})
      test_patron1.save()
      test_book1 = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test_book1.save()
      test_book1.update({:patron_ids => [test_patron1.patron_id()]})
      expect(test_book1.patrons()).to(eq([test_patron1]))
    end
end

  describe('#patrons') do
    it('returns all patrons the book has') do
      test_patron1 = Patron.new({:patron_name => 'Susan'})
      test_patron1.save()
      id1 = test_patron1.patron_id()
      test_patron2 = Patron.new({:patron_name => 'Kendra'})
      test_patron2.save()
      id2 = test_patron2.patron_id()
      test_book1 = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test_book1.save()
      test_book1.update({:patron_ids => [id1, id2]})
      expect(test_book1.patrons()).to(eq([test_patron1, test_patron2]))
    end
  end

  describe('#delete') do
    it('deletes a book from a database') do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      test.save()
      id = test.book_id()
      test.delete()
      expect(Book.find(id)).to(eq(nil))
    end
  end
end
