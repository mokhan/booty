class DatabaseGateway
  def initialize(context, key)
    @context = context
    @key = key
  end
  def run(command_or_query)
    command_or_query.run(connection)
  end

  private

  def connection
    session = @context.item_for(@key)
    session.connection
  end
end
