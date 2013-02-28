require "spec_helper"

describe Repository do
  let(:sut) { Repository.new(Product, :products, gateway) }
  let(:gateway) { DatabaseGateway.new( DatabaseConnectionFactory.new(DatabaseConfiguration.new, SequelConnectionProvider.new)) }

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
  context "when saving a new item" do
    let(:product) { Product.new(:name => 'blah') }
    before :each do
      sut.save(product)
    end
    after :each do
      TestDatabaseGateway.delete_all
    end
    it "should insert a new record into the database" do
      found = TestDatabaseGateway.connection.from(:products)
      found.count.should == 1
    end
    it "should update the product with its new id" do
      product.id.should be > 0
    end
  end
  context "when saving an existing item" do
    before :each do
      TestDatabaseGateway.connection.from(:products).insert(:name => 'foo')
      result = sut.find_all.first
      result.change_name('bar')
      sut.save(result)
    end
    after :each do
      TestDatabaseGateway.connection.from(:products).delete
    end
    it "should update the product with the latest changes" do
      found = TestDatabaseGateway.connection.from(:products).first
      found[:name].should == 'bar'
    end
  end
  context "when fetching an item by its id" do
    context "when the id exists" do
      before :each do
        @id = TestDatabaseGateway.connection.from(:products).insert(:name => 'blah')
      end

      let(:result) { sut.find_by(@id) }

      it "should return the item" do
        result.should == Product.new(:id => @id, :name => 'blah')
      end

      after :each do
        TestDatabaseGateway.connection.from(:products).delete
      end
    end
  end
end
