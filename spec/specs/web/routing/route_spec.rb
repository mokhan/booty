require "spec_helper"

describe Route do
  let(:sut) { Route.new(command, container, load_strategy) }
  let(:command) { String }
  let(:container) { fake }
  let(:load_strategy) { fake }

  context "when run" do
    let(:request) { fake }
    let(:new_instance) { fake }

    before :each do
      container.stub(:build).with(command).and_return(new_instance)
      sut.run(request)
    end

    it "should build and run the command" do
      new_instance.should have_received(:run, request)
    end
    it "should reload the file" do
      load_strategy.should have_received(:reload, command)
    end
  end
  context "when matching" do
    let(:request) { fake }
    let(:now) { Time.now.nsec }

    before :each do
      command.stub(:matches?).with(request).and_return(now)
    end

    let(:result) { sut.matches?(request) }

    it "should delegate to the command" do
      result.should == now
    end
  end
end
