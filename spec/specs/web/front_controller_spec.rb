require 'spec_helper'

module Booty
  describe FrontController do
    let(:command_registry) { fake }
    let(:view_engine) { fake }
    let(:sut) { FrontController.new(command_registry, view_engine) }

    context "when a new request is received" do
      let(:correct_command) { fake }
      let(:incorrect_command) { fake }
      let(:template_result) { fake }
      let(:response) { [] }
      let(:env) { {} }
      before(:each) do
        command_registry.stub(:route_for).with(env).and_return(correct_command)
        correct_command.stub(:run).and_return(template_result)
        template_result.stub(:run).with(view_engine).and_return(response)
      end
      before(:each) do
        @result = sut.call(env)
      end
      it "should process the request using the proper command" do
        correct_command.should have_received(:run, env)
      end
      it "should not invoke any other commands" do
        incorrect_command.should_not have_received(:run, env)
      end
      it "should return the result of the command" do
        @result.should == response
      end
    end
    context "when handling a request fails" do
      let(:error) { StandardError.new("blah") }
      let(:env) { {} }
      let(:html) { "<html></html>" }
      before :each do
        def command_registry.route_for(item)
          raise error
        end
        view_engine.stub(:render).and_return(html)
      end
      before :each do
        @result = sut.call(env)
      end
      it "should render the 501 template" do
        @result.should == [501, {"Content-Type" => "text/html"}, [html]]
      end
    end
  end
end
