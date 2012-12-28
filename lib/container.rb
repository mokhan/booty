class Container
  def initialize
    @items = {}
    register(:container) { self }
  end
  def register(key, &block)
    items_for(key).push(block)
  end
  def resolve(key)
    instantiate(items_for(key).first)
  end
  def resolve_all(key)
    items_for(key).map {|item| instantiate(item) }
  end

  private

  def items_for(key)
    @items[key] = [] unless @items[key]
    @items[key]
  end
  def instantiate(factory_method)
    factory_method.call(self)
  end
end
