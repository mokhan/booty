require "spec_helper"

describe "Product Mapping" do
  context "finding all products" do
    let(:product) { Product.new(:name => 'book') }
    before :each do
      connection_string = DatabaseConfiguration.new.connection_string
      configuration = Humble::Configuration.new(connection_string)
      configuration.add(ProductMapping.new)
      session_factory = configuration.build_session_factory
      @session = session_factory.create_session
    end

    let(:results) { @session.find_all(Product) }

    it "should be able to load all Products" do
      results.should include(product)
    end
  end
end