class UnitOfWorkInterceptor
  def initialize(unit_of_work_factory)
    @unit_of_work_factory = unit_of_work_factory
  end
  def intercept(invocation)
    p "INTERCEPT #{invocation}"
    UnitOfWork.create(@unit_of_work_factory) do |unit_of_work|
      p "PROCEEDING"
      invocation.proceed
      unit_of_work.commit
    end
  end
end
