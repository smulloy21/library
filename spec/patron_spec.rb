require('spec_helper')

describe(Patron) do
  describe('#patron_name') do
    it('returns the patrons name') do
      test_patron = Patron.new({:patron_name => 'Joe'})
      expect(test_patron.patron_name()).to(eq('Joe'))
    end
  end

  describe('.all') do
    it('will return and empty array') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('returns equal if two patrons have the same id') do
      test = Patron.new({:patron_name => 'Joe'})
      test2 = Patron.new({:patron_name => 'Joe'})
      expect(test).to(eq(test2))
    end
  end

  describe('#save') do
    it('saves a patron to the database') do
      test = Patron.new({:patron_name => 'Joe'})
      test.save()
      expect(Patron.all()).to(eq([test]))
    end
  end

  describe('.find') do
    it('finds a person by their id') do
      test = Patron.new({:patron_name => 'Susan'})
      test.save()
      expect(Patron.find(test.patron_id())).to(eq(test))
    end
  end

  describe('#update') do
    it("updates a patrons name that matches the id") do
      test = Patron.new({:patron_name => 'Susan'})
      test.save()
      test.update({:patron_name => 'susie'})
      expect(test.patron_name()).to(eq('susie'))
    end
  end

  describe('#delete') do
    it('deletes a patron from a database') do
      test = Patron.new({:patron_name => 'Mike'})
      test.save()
      id = test.patron_id()
      test.delete()
      expect(Patron.find(id)).to(eq([]))
    end
  end
end
