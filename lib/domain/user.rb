require "domain_object"

class User < DomainObject
  def change_password(password)
    @password = password
  end

  def password_matches(other_password)
    @password == other_password
  end
end
