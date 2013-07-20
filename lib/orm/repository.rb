require "queries"
require "commands"

class Repository
  def initialize(table, database_gateway, data_mapper)
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
    return Commands.update_command_for(@table, item) if item.id > 0
    Commands.insert_command_for(@table, item)
  end

  def run(command)
    @database_gateway.run(command)
  end
end
