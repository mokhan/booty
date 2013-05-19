  class CookieJar
    def initialize(cookies = [])
      @cookies = cookies
    end

    def add(cookie)
      cookies.push(cookie)
    end

    def add_to(headers)
      cookies.each do |cookie|
        cookie.prepare(headers)
      end
      headers
    end

    def include?(cookie)
      cookies.include?(cookie)
    end

    private

    attr_reader :cookies
  end
