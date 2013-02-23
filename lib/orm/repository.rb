require 'database_query'
require "database_command"

class Repository
  def initialize(clazz, table, database_gateway)
    @clazz = clazz
    @table = table
    @database_gateway = database_gateway
  end

  def find_all
    @database_gateway.run(create_query { |c| c.from(@table).all }).map { |item| @clazz.new(item) }
  end

  def save(item)
    @database_gateway.run(create_save_command_for(item))
  end

  private

  def create_save_command_for(item)
    return create_command { |connection| connection[@table].update(item.attributes) } if item.id > 0

    create_command do |connection|
      id = connection[@table].insert(item.attributes.delete_if {|key, value| key == :id })
      item.instance_variable_set(:@id, id)
    end
  end

  def create_command
    DatabaseCommand.new { |connection| yield(connection) }
  end

  def create_query
    DatabaseQuery.new { |connection| yield(connection) }
  end
end
