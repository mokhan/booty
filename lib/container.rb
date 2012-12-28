class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(symbol, &block)
    @items[symbol] = block
  end
  def resolve(symbol)
    p "resolving #{symbol} at #{Time.now}"
    @items[symbol].call(self)
  end
end
