require "spec_helper"

describe RequestSpecification do

  context "when matching a uri path" do
    let(:sut) { RequestSpecification.new :uri => /^\/products$/ }

    it "should match when given the proper uri" do
      request = { "REQUEST_PATH" => '/products'}
      sut.matches?(request).should be_true
    end
    it "should not match a uri for a different path" do
      request = { "REQUEST_PATH" => '/products/1'}
      sut.matches?(request).should be_false
    end
  end
  context "when matching a path and a verb" do
    let(:sut) { RequestSpecification.new :uri => /posters/, :verb => :PUT }

    it "should match when given the proper request" do
      request = { "REQUEST_PATH" => '/posters', "REQUEST_METHOD" => "PUT" }
      sut.matches?(request).should be_true
    end
    it "should not match if the uri is incorrect" do
      request = { "REQUEST_PATH" => '/lamas', "REQUEST_METHOD" => "PUT" }
      sut.matches?(request).should be_false
    end
    it "should not match if the verb is incorrect" do
      request = { "REQUEST_PATH" => '/posters', "REQUEST_METHOD" => "GET" }
      sut.matches?(request).should be_false
    end
  end
  context "when matching a route with an id" do
    let(:sut) { RequestSpecification.new :uri => /^\/products\/[0-9]+$/ }
    #let(:sut) { RequestSpecification.new :uri => /^\/products\/(\d+)+$/ }

    it "should match when given a proper route" do
      request = { "REQUEST_PATH" => '/products/100' }
      sut.matches?(request).should be_true
    end
    it "should not match other routes" do
      request = { "REQUEST_PATH" => '/products' }
      sut.matches?(request).should be_false
    end
  end
end
