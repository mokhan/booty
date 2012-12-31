class BlockMatch
  def initialize(&block)
    @block = block
  end
  def matches(item)
    @block.call(item)
  end
end
