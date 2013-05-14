require "spec_helper"

describe Booty::Products::NewCommand do
  let(:sut) { Booty::Products::NewCommand.new(view_engine) }
  let(:view_engine) { fake }

  context "when run" do
    let(:html) { DateTime.now.to_s }

    before :each do
      @result = sut.run({})
    end

    it "should return the proper status" do
      @result.status.should == 200
    end

    it "should return the proper template" do
      @result.template.should == '/products/new'
    end
  end
end
