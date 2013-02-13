require 'database_query'

class Repository
  def initialize(clazz, table, database_gateway)
    @clazz = clazz
    @table = table
    @database_gateway = database_gateway
  end
  def find_all
    @database_gateway.run(DatabaseQuery.new{|c| c.from(@table).all }).map {|item| @clazz.new(item) }
  end
end
