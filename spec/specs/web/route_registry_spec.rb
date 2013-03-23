require 'spec_helper'

module Booty
  describe RouteRegistry do
    let(:sut) { RouteRegistry.new }

    context "when looking up which command can process a request" do
      let(:correct_command) { fake }
      let(:other_command) { fake }
      let(:request) { {} }

      before :each do
        sut.register(correct_command) { |request| true }
        sut.register(other_command) { |request| false }
      end

      before :each do
        @result = sut.route_for(request).command
      end
      it "should return the command that can process the request" do
        @result.should == correct_command
      end
      it "should not return commands that cannot process the request" do
        @result.should_not == other_command
      end
    end

    context "when registering a route" do
      let(:command) { fake }
      let(:other_command) { fake }

      before :each do
        sut.register(command) do |request|
          request == "BLAH"
        end
        sut.register(other_command) do |request|
          request == "MOO"
        end
      end
      it "should return the command that matches the first route" do
        sut.route_for("BLAH").command.should == command
      end
      it "should return a command that matches the second route" do
        sut.route_for("MOO").command.should == other_command
      end
    end

    context "when registering a route without a block" do
      let(:command) { fake }
      before :each do
        command.stub(:matches?).with("mee").and_return(true)
        sut.register(command)
      end
      it "should use the command for matching" do
        sut.route_for("mee").command.should == command
      end
    end
  end
end
