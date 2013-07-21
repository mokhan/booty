class HumbleRepository
  def initialize(session, target_type)
    @session = session
    @target_type = target_type
  end

  def find_by(id)
    find_all.find { |x| x.id == id }
  end

  def find_all
    @session.find_all(@target_type)
  end

  def save(item)
    @session.save(item)
  end
end
