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
    end
  end
  context "when displaying the product" do
    let(:result) { sut.to_s }

    it "should dump the value of each attribute" do
      result.should include sut.id.to_s
      result.should include sut.name
    end
  end
end
