require 'database_query'
require "database_command"

class Repository
  def initialize(clazz, table, database_gateway)
    @clazz = clazz
    @table = table
    @database_gateway = database_gateway
  end
  def find_all
    @database_gateway.run(DatabaseQuery.new{|c| c.from(@table).all }).map {|item| @clazz.new(item) }
  end
  def save(item)
    attributes = item.attributes
    if attributes[:id] > 0 
    else
      @database_gateway.run(prepare_insert_command_for(item))
    end
  end

  private

  def prepare_insert_command_for(item)
    attributes = item.attributes
    DatabaseCommand.new do |connection|
      item.id = connection[@table].insert(attributes.delete_if {|key, value| key == :id } )
    end
  end
end
