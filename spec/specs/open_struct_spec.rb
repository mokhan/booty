require 'spec_helper'

describe OpenStruct do
  describe "play with binding" do
    let(:sut){ OpenStruct.new(:name => 'mo') }
    before(:each) do
      sut.extend(Booty::ExposeBindingBehaviour)
    end

    it "should allow me to access the getter" do
      sut.name.should == 'mo'
    end

    it "should allow access through the binding" do
      eval("name", sut.get_binder).should == 'mo'
    end
  end
end
