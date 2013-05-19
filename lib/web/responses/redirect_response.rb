module Booty
  class RedirectResponse
    attr_reader :location, :status

    def initialize(location: '/')
      @location = location
      @status = 301
    end

    def run(view_engine)
      headers = {"Location" => @location}
      #Rack::Utils.set_cookie_header!(headers, 'blah', 'huh')
      [@status, headers, []]
    end
  end
end
