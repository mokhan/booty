require 'spec_helper'

module Booty
  describe CommandRegistry do
    let(:sut) { CommandRegistry.new }

    context "when looking up which command can process a request" do
      let(:correct_command) { fake }
      let(:other_command) { fake }
      let(:request) { {} }

      before :each do
        sut.register_route(correct_command) { |request| true }
        sut.register_route(other_command) { |request| false }
      end

      before :each do
        @result = sut.command_for(request)
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
        sut.register_route(command) do |request|
          request == "BLAH"
        end
        sut.register_route(other_command) do |request|
          request == "MOO"
        end
      end
      it "should return the command that matches the first route" do
        sut.command_for("BLAH").should == command
      end
      it "should return a command that matches the second route" do
        sut.command_for("MOO").should == other_command
      end
    end

  end
end
