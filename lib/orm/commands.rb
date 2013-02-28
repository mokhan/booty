require "database_command"

class Commands
  def self.update_command_for(table, item)
    create_command { |connection| connection[table].update(item.attributes) }
  end

  def self.insert_command_for(table, item)
    create_command do |connection|
      id = connection[table].insert(item.attributes.delete_if {|key, value| key == :id })
      item.instance_variable_set(:@id, id)
    end
  end

  private

  def self.create_command
    DatabaseCommand.new { |connection| yield(connection) }
  end
end
