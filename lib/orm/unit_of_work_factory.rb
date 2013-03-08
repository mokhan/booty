class UnitOfWorkFactory
  def initialize(context, session_factory, key)
    @context = context
    @session_factory = session_factory
    @key = key
  end
  def create
    @context.contains?(@key) ?  NullUnitOfWork.new : UnitOfWork.new(@session_factory.create, @context, @key)
  end
end
