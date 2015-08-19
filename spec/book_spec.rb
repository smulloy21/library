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

  
end
