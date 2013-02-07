require 'sequel'

class SequelConnectionProvider
  def provide
    Sequel
  end
end
