require "spec_helper"

describe Repository do
  let(:sut) { Repository.new(Product, :products) }

  context "when fetching all products from the database" do
    let(:product) { Product.new(:id => 1, :name => "putty") }

    before :each do
      TestDatabaseGateway.connection.from(:products).insert(:name => product.name)
      @results = sut.find_all
    end
    after :each do
      TestDatabaseGateway.connection.from(:products).delete
    end
    it "should return each product" do
      @results.count.should == 1
    end
    it "should return a product" do
      @results.first.should be_an_instance_of(Product)
    end
    it "should map the name properly" do
      @results.first.name.should == product.name
    end
    it "should map the id properly" do
      @results.first.id.should_not be_nil
    end
  end
end
