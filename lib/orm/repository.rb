require 'database_query'
require "database_command"

class Repository
  def initialize(clazz, table, database_gateway)
    @clazz = clazz
    @table = table
    @database_gateway = database_gateway
  end

  def find_all
    @database_gateway.run(DatabaseQuery.new { |c| c.from(@table).all }).map { |item| @clazz.new(item) }
  end

  def save(item)
    if item.id > 0
      @database_gateway.run(prepare_update_command_for(item))
    else
      @database_gateway.run(prepare_insert_command_for(item))
    end
  end

  private

  def prepare_update_command_for(item)
    create_command { |connection| connection[@table].update(attributes_for(item)) }
  end

  def prepare_insert_command_for(item)
    create_command do |connection|
      item.instance_variable_set(:@id, connection[@table].insert(attributes_for(item).delete_if {|key, value| key == :id }))
    end
  end

  def attributes_for(item)
    attributes = Hash.new
    item.instance_variables.each do |variable|
      attributes[variable.to_s.gsub(/@/, '').to_sym] = item.instance_variable_get(variable)
    end
    attributes
  end

  def create_command
    DatabaseCommand.new { |connection| yield(connection) }
  end
end
