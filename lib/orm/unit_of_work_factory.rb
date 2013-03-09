class UnitOfWorkFactory
  def initialize(context, session_factory, key)
    @context = context
    @session_factory = session_factory
    @key = key
  end

  def create
    @context.contains?(@key) ?  NullUnitOfWork.new : create_unit_of_work
  end

  private

  def create_unit_of_work
    session = @session_factory.create
    @context.add(@key, session)
    UnitOfWork.new(session, @context, @key)
  end
end
