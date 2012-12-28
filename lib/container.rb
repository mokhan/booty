class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(symbol, &block)
    @items[symbol] = [] unless @items[symbol]
    @items[symbol].push(block)
  end
  def resolve(symbol)
    @items[symbol].first.call(self)
  end
  def resolve_all(symbol)
    @items[symbol].map {|item| item.call(self) }
  end
end
