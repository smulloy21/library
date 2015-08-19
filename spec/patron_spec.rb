require('spec_helper')

describe(Patron) do
  describe('#patron_name') do
    it('returns the patrons name') do
      test_patron = Patron.new({:patron_name => 'Joe'})
      expect(test_patron.patron_name()).to(eq('Joe'))
    end
  end
end
