class Booty::Products::CreateCommand
  def initialize(repository)
    @repository = repository
  end
  def run(request)
    form = form_from(request)
    @repository.save(Product.new(:name => form["name"]))
  end

  private 

  def form_from(request)
    items = request['rack.input'].string.split(/\r?\n/)
    hash = Hash.new
    items.each do |item|
      key, value = item.split("=")
      hash[key] = value
    end
    hash
  end
end
