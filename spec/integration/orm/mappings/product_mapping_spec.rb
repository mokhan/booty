require "integration_helper"

describe "Product Mapping" do
  context "finding all products" do
    let(:product) { Product.new(:name => 'book') }

    before :each do
      @configuration.add(ProductMapping.new)
      @session = @session_factory.create_session
      @session.save(product)
    end

    let(:results) { @session.find_all(Product) }

    it "should be able to load all Products" do
      results.should include(product)
    end

    it "should return the correct number of results" do
      results.count.should == 1
    end
  end
end
