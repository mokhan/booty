class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(symbol, &block)
    @items[symbol] = block
  end
  def resolve(symbol)
    @items[symbol].call(self)
  end
end
