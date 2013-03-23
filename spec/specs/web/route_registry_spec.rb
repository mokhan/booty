require 'spec_helper'

module Booty
  describe RouteRegistry do
    let(:sut) { RouteRegistry.new }

    context "when registering a route" do
      let(:command) { fake }

      before :each do
        command.stub(:matches?).with("mee").and_return(true)
        sut.register(command)
      end
      it "should use the command for matching" do
        sut.route_for("mee").should == command
      end
    end
  end
end
