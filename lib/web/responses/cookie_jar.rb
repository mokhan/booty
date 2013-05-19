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
