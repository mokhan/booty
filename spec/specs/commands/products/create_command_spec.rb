require "spec_helper"
require 'rack'

describe Booty::Products::CreateCommand do
  let(:sut) { Booty::Products::CreateCommand.new(repository) }
  let(:repository) { fake }

  context "when creating a new product" do
    let(:product) { fake }
    let(:request) { fake }

    before :each do
      request.stub(:payload).and_return({:product => {:name => 'blah'}})
      Product.stub(:new).with(:name => 'blah').and_return(product)
      @result = sut.respond_to(request)
    end

    it "should save a new product" do
      repository.should have_received(:save, product)
    end

    it "should redirect to the product listing" do
      @result.status.should == 301
      @result.location.should == '/products'
    end
  end
end
