class Patron
  attr_reader(:patron_name, :patron_id)

  define_method(:initialize) do |attributes|
    @patron_name = attributes.fetch(:patron_name)
    @patron_id = attributes.fetch(:patron_id, nil)
  end
end
