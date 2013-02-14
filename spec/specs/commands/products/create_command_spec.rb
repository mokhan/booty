require "spec_helper"

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

describe Booty::Products::CreateCommand do
  let(:sut) { Booty::Products::CreateCommand.new(repository) }
  let(:repository) { fake }

  context "when creating a new product" do
    let(:product) { fake }
    let(:form) { StringIO.new }

    before :each do
      form.puts "name=blah"
      Product.stub(:new).with(:name => 'blah').and_return(product)
      sut.run({ "rack.input" => form })
    end

    it "should save a new product" do
      repository.should have_received(:save, product)
    end
  end
end
