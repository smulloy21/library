class Patron
  attr_reader(:patron_name, :patron_id)

  define_method(:initialize) do |attributes|
    @patron_name = attributes.fetch(:patron_name)
    @patron_id = attributes.fetch(:patron_id, nil)
  end

  define_singleton_method(:all) do
    result = DB.exec("SELECT * FROM patrons;")
    patrons = []

    result.each() do |patron|
      name = patron.fetch("patron_name")
      id = patron.fetch("patron_id")
      patrons.push(Patron.new({:patron_name => name, :patron_id => id}))
    end
    patrons
  end



end
