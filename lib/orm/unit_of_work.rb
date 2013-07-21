class UnitOfWork
  def initialize(session, context, key)
    @session = session
    @context = context
    @key = key
  end

  def run(&block)
    @session.begin_transaction(&block)
  end

  def dispose
    @context.remove(@key)
    @session.dispose
  end

  def self.create(factory, &block)
    unit_of_work = factory.create
    begin
      unit_of_work.run(&block)
    ensure
      unit_of_work.dispose
    end
  end
end
