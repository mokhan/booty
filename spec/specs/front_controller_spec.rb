require '../spec_helper'

describe FrontController do
  let(:command_registry) { fake }
  let(:sut) { FrontController.new(command_registry) }

  context "when a new request is received" do
    let(:correct_command) { fake }
    let(:incorrect_command) { fake }
    let(:response) { [] }
    before(:each) do
      command_registry.stub(:command_for).with(env).and_return(correct_command)
      correct_command.stub(:run_against).and_return(response)
    end
    before(:each) do
      @result = sut.call(env)
    end
    it "should process the request using the proper command" do
      correct_command.should have_received(:run_against, env)
    end
    it "should not invoke any other commands" do
      incorrect_command.should_not have_received(:run_against, env)
    end
    it "should return the result of the command" do
      @result.should == response
    end
  end
end
