require "spec_helper"

describe Container do
  let(:sut) { Container.new }

  describe "when resolving an item that has been registered" do
    let(:registered_item) { Object.new }
    before :each do
      sut.register(:item) do
        registered_item
      end
    end
    before :each do
      @result = sut.resolve(:item) 
    end
    it "should return the registered item" do
      @result.should == registered_item
    end
  end
  describe "when resolving the container" do
    it "should return itself" do
      sut.resolve(:container).should == sut
    end
  end
  describe "when multiple items are registered with the same key" do
    context "when resolving a single item" do
      pending "should return the first one registered" do
        
      end
    end
    context "when resolving all items" do
      pending "should return them all" do
        
      end
    end
  end
end
