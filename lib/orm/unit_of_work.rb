class UnitOfWork
  def initialize(session, context, key)
    @session = session
    @context = context
    @key = key
  end
  def commit
    @session.flush
  end
  def dispose
    @context.remove(@key)
    @session.dispose
  end
end
