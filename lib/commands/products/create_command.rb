class Booty::Products::CreateCommand < Booty::RouteCommand
  handles :uri => /\/products$/, :method => :POST

  def initialize(products_repository)
    @repository = products_repository
  end

  def respond_to(request)
    @repository.save(map_from(request.payload))
    [301, {"Location" => '/products'}, []]
  end

  private 
  def map_from(payload)
    Product.new(:name => payload[:name])
  end
end
