class BlockMatch
  def initialize(&block)
    @block = block
  end
  def matches(item)
    @block.call(item)
  end

  def or(other_specification)
    BlockMatch.new do |item|
      self.matches(item) || other_specification.matches(item)
    end
  end
end
