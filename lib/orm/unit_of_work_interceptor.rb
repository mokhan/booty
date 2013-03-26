class UnitOfWorkInterceptor
  def initialize(unit_of_work_factory)
    @unit_of_work_factory = unit_of_work_factory
  end

  def intercept(invocation)
    UnitOfWork.create(@unit_of_work_factory) do
      invocation.proceed
    end
  end
end
