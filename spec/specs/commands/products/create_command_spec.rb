require "spec_helper"

describe Booty::Products::CreateCommand do
  let(:sut) { Booty::Products::CreateCommand.new(repository) }
  let(:repository) { fake }

  context "when creating a new product" do
    let(:product) { fake }
    let(:form) { StringIO.new }

    before :each do
      form.puts "name=blah"
      Product.stub(:new).with(:name => 'blah').and_return(product)
      @result = sut.run({ "rack.input" => form })
    end

    it "should save a new product" do
      repository.should have_received(:save, product)
    end

    it "should redirect to the product listing" do
      @result.should == [301, {"Location" => '/products'}, nil]
    end
  end
end
