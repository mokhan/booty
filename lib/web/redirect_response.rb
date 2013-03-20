module Booty
  class RedirectResponse
    attr_reader :location, :status

    def initialize(location: '/')
      @location = location
      @status = 301
    end
    def run(view_engine)
      [@status, {"Location" => @location}, []]
    end
  end
end
