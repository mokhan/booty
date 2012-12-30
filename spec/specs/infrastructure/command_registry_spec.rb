require 'spec_helper'

module Booty
  describe CommandRegistry do
    let(:container) { fake }
    let(:sut) { CommandRegistry.new(container) }

    context "when looking up which command can process a request" do
      let(:correct_command) { fake }
      let(:other_command) { fake }
      let(:request) { {} }
      before :each do
        correct_command.stub(:matches).with(request).and_return(true)
        other_command.stub(:matches).with(request).and_return(false)
        container.stub(:resolve_all).with(:http_command).and_return([other_command, correct_command])
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
    context "when a command cannot be found to process a request" do
      let(:other_command) { fake }
      let(:request) { {} }
      before :each do
        other_command.stub(:matches).with(request).and_return(false)
        container.stub(:resolve_all).with(:http_command).and_return([other_command])
      end
      before :each do
        @result = sut.command_for(request)
      end
      it "should return the DefaultCommand" do
        @result.should be_a_kind_of(DefaultCommand)
      end
    end
  end
end
