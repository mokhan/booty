require "domain_object"
require "bcrypt"

class User < DomainObject
  attr_reader :username

  def change_password(password)
    @password_hash = BCrypt::Password.create(password)
  end

  def password_matches(other_password)
    password == other_password
  end

  private 

  def password
    BCrypt::Password.new(@password_hash)
  end
end
