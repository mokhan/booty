class DatabaseQuery
  def initialize(&lambda)
    @lambda = lambda
  end
  def run(connection)
    @lambda.call(connection)
  end
end
