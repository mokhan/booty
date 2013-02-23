require "domain_object"

class Product < DomainObject
  attr_reader :name

  def change_name(new_name)
    @name = new_name
  end
end
