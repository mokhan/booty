
module Booty
  module Products
    class ShowCommand < RouteCommand
      handles :uri => /^\/products\/(\d+)+$/, :method => :GET
    end
  end
end
