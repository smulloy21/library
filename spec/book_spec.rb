require('spec_helper')

describe(Book) do
  describe('#title') do
    it("return the title of the book") do
      test = Book.new({:title => 'The Captains Daughter', :author => 'Alexander Pushkin'})
      expect(test.title()).to(eq('The Captains Daughter'))
    end
  end
end
