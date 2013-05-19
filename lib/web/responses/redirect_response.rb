module Booty
  module Cookies
    SESSION=:s
  end
  class Cookie
    attr_reader :name

    def initialize(name, value)
      @name = name
      @value = value
    end

    def prepare(headers)
      Rack::Utils.set_cookie_header!(headers, @name, @value)
    end

    def ==(other)
      @name = other.name
    end
  end

  class CookieJar
    def initialize(cookies = [])
      @cookies = cookies
    end

    def add(cookie)
      @cookies.push(cookie)
    end

    def add_to(headers)
      cookies.each do |cookie|
        cookie.prepare(headers)
      end
    end

    def include?(cookie)
      @cookies.include?(cookie)
    end
  end
  class RedirectResponse
    attr_reader :location, :status, :cookie_jar

    def initialize(location: '/')
      @location = location
      @status = 301
      @cookie_jar = CookieJar.new
    end

    def add(cookie)
      cookie_jar.add(cookie)
      self
    end

    def run(view_engine)
      [@status, cookie_jar.add_to({"Location" => @location}), []]
    end

    private

    def cookies
      @cookies || []
    end
  end
end
