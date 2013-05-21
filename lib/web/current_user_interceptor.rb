class CurrentUserInterceptor
  def initialize(container)
    @container = container
  end

  def intercept(invocation)
    invocation.proceed
  end
end
