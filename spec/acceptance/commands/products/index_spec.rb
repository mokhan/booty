require "acceptance_helper"

module Booty
  describe "/products" do
    let(:sut) { Watir::Browser.new }
    before :all do
      TestDatabaseGateway.connection.from(:products).insert(:name => "Book")
      TestDatabaseGateway.connection.from(:products).insert(:name => "Phone")
      TestDatabaseGateway.connection.from(:products).insert(:name => "Lamp")
      sut.goto 'http://localhost:9292/products'
    end
    after :all do
      sut.close
      TestDatabaseGateway.connection.from(:products).delete
    end
    it "should say hello world" do
      sut.text.include?('Products').should be_true
    end
    it "should have a title" do
      sut.title.should == 'Products - Booty'
    end
    it "should display each product" do
      sut.text.include?('Book').should be_true
      sut.text.include?('Phone').should be_true
      sut.text.include?('Lamp').should be_true
    end
  end
end
