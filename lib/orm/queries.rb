require 'database_query'

class Queries
  def self.find_all(table)
    create_query { |c| c.from(table).all }
  end

  def self.find_single(table, options)
    create_query { |c| c.from(table).where(options).first }
  end

  private

  def self.create_query
    DatabaseQuery.new { |connection| yield(connection) }
  end
end
