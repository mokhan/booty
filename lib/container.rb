class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(key, &block)
    @items[key] = [] unless @items[key]
    @items[key].push(block)
  end
  def resolve(key)
    @items[key].first.call(self)
  end
  def resolve_all(key)
    @items[key].map {|item| item.call(self) }
  end
end
