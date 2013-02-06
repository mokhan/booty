require "spec_helper"
require "sequel"

describe SequelConnectionProvider do
  let(:sut) { SequelConnectionProvider.new }

  context "when providing a connection" do
    before :each do
      @result = sut.provide
    end
    it "should provider the Sequel api gateway" do
      @result.should == Sequel
    end
  end
end
