require "spec_helper"

module Booty
  describe Lazy do
    context "when lazy loading an item from a container" do
      context "when invoking a method on the proxy" do
        let(:container) { fake }
        let(:blackbook) { fake }

        before :each do
          blackbook.stub(:find).and_return("booty call")
          container.stub(:resolve).with(:blackbook).and_return(blackbook)
          IOC.bind_to(container)
        end

        it "should invoke the target" do
          Lazy.load(:blackbook).find(:booty).should == "booty call"
        end
      end
      context "before invocation" do
        let(:container) { fake }

        before :each do
          IOC.bind_to(container)
          Lazy.load(:blackbook)
        end

        it "should not resolve the component from the container" do
          container.should_not have_received(:resolve)
        end
      end
    end
  end
end
