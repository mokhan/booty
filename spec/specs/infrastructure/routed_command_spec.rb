require "spec_helper"
module Booty
  describe RoutedCommand do
    let(:sut) { RoutedCommand.new(specification, command) }
    let(:specification) { fake }
    let(:command) { fake }

    context "when matching" do
      context "when matched" do
        before :each do
          specification.stub(:matches).with("blah").and_return(true)
        end
        it "should delegate to the specification given" do
          sut.matches("blah").should be_true
        end
      end
      context "when not matched" do
        before :each do
          specification.stub(:matches).with("blah").and_return(false)
        end
        it "should delegate to the specification given" do
          sut.matches("blah").should be_false
        end
      end
    end

    context "when run" do
      let(:request) { {  :path => "BLAH" } }
      before :each do
        sut.run(request)
      end
      it "should run the command" do
        command.should have_received(:run, request)
      end
    end
  end
end
