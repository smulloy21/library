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

  define_method(:==) do |other|
    self.patron_id == other.patron_id
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (patron_name) VALUES ('#{@patron_name}') RETURNING patron_id;")
    @patron_id = result.first().fetch('patron_id')
    @patron_id.to_i()
  end

  define_singleton_method(:find) do |id|
     Patron.all().each() do |patron|
       if patron.patron_id() == id
         return patron
       end
     end
   end

   define_method(:update) do |attributes|
     @patron_name = attributes.fetch(:patron_name)
     @id = self.patron_id()
     DB.exec("UPDATE patrons SET patron_name = '#{@patron_name}' WHERE patron_id = #{@id};")
   end

end
