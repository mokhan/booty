require "spec_helper"

class RoutingCommand
  include RoutingModule

  handles :uri => /\/products$/, :verb => :GET
end

describe RoutingModule do
  let(:sut) { RoutingCommand.new }
  context "when declaratively describing what routes are handled" do
    it "should match proper routes" do
      request = { "REQUEST_PATH" => '/products', "REQUEST_METHOD" => "GET" }
      sut.matches(request).should be_true
    end
    it "should not match routes that do not match" do
      request = { "REQUEST_PATH" => '/games' }
      sut.matches(request).should be_false
    end
  end
end
