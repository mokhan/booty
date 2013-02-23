module Identifiable
  attr_reader :id
  DEFAULT_ID = -1

  def ==(other)
    return true if other.object_id == object_id
    return false if self.id == DEFAULT_ID || other.class != self.class
    id == other.id
  end
end
