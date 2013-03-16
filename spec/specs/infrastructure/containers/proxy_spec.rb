require "spec_helper"

module Booty
  describe Proxy do
    let(:sut) { Proxy.new(target) }
    let(:target) { fake }

    context "when invoking a method" do
      before :each do
        sut.greet('blah')
      end
      it "should send the message to the target" do
        target.should have_received(:greet, 'blah')
      end
    end

    context "when an interceptor is registered" do
      context "when invoking a method" do
        let(:interceptor) { fake }

        before :each do
          sut.add(:greet, interceptor)
          sut.greet("blah")
        end
        it "should allow the interceptor to intercept the call" do
          interceptor.should have_received(:intercept)
        end
      end
    end
  end
end
