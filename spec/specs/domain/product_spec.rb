require "spec_helper"

describe Product do
  let(:sut) { Product.new(:id => 1, :name => 'blah') }

  context "when changing a products name" do
    before :each do
      sut.change_name('new name')
    end
    it "should have the new name" do
      sut.name.should == "new name"
    end
  end
  context "when a product has not been saved" do
    it "should have a default id of -1" do
      Product.new(:name => '').id.should == -1
      Product.new.id.should == -1
    end
  end
  context "when comparing two products" do
    context "when they have the same id" do
      it "should be equal" do
        id = Time.now.nsec
        Product.new(:id => id).should == Product.new(:id => id)
      end
      context "when they are different types" do
        it "should not be equal" do
          Product.new(:id => 1).should_not == OpenStruct.new(:id => 1)
        end
      end
      context "when they are the same instance" do
        it "should return true" do
          product = Product.new
          product.should == product
        end
      end
      context "when they have the default id" do
        it "should not be equal" do
          Product.new.should_not == Product.new
        end
      end
    end
    context "when they have different ids" do
      it "should not be equal" do
        Product.new(:id => 1).should_not == Product.new(:id => 2)
      end
    end
  end
  context "when creating an instance" do
    let(:product){ Product.new(:id => 1, :name => 'blah', :color => 'black') }

    it "should create an instance variable for each key in the attribute hash" do
      product.instance_variable_get(:@id).should == 1
      product.instance_variable_get(:@name).should == 'blah'
      product.instance_variable_get(:@color).should == 'black'
    end
  end
end
