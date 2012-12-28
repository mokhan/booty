
require 'spec_helper'

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
describe OpenStruct do
  describe "play with binding" do
    let(:sut){ OpenStruct.new(:name => 'mo') }
    before(:each) do
      sut.extend(ExposeBindingBehaviour)
    end

    it "should allow me to access the getter" do
      sut.name.should == 'mo'
    end

    it "should allow access through the binding" do
      eval("name", sut.get_binder).should == 'mo'
    end
  end
end
