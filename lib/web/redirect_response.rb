module Booty
  class RedirectResponse
    def initialize(location: '/')
      @location = location
    end
    def run
      [301, {"Location" => @location}, []]
    end
  end
end
