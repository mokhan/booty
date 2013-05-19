  class Cookie
    attr_reader :name

    def initialize(name, value)
      @name = name
      @value = value
    end

    def prepare(headers)
      Rack::Utils.set_cookie_header!(headers, @name, {:value => @value, :path => "/", :expires => Time.now+(336*60*60)})
    end

    def ==(other)
      @name = other.name
    end
  end
