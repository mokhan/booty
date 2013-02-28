require 'database_query'
require "database_command"
require "queries"

class Repository
  def initialize(clazz, table, database_gateway, data_mapper = DataMapper.new(clazz))
    @table = table
    @database_gateway = database_gateway
    @data_mapper = data_mapper
  end

  def find_by(id)
    run(Queries.find_single(@table,{ :id => id })).map_using(@data_mapper)
  end

  def find_all
    run(Queries.find_all(@table)).map_all_using(@data_mapper)
  end

  def save(item)
    run(create_save_command_for(item))
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

  def run(command)
    @database_gateway.run(command)
  end

end
