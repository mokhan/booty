module Booty
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
