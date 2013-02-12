require "spec_helper"

class RouteRequestSpecification
  def handles(route)
    @options = route
  end
  def matches(request)
    matches_path(request) && matches_verb(request)
  end
  private
  def matches_path(request)
    @options[:uri].match request["REQUEST_PATH"]
  end
  def matches_verb(request)
    @options.has_key?(:verb) ? @options[:verb].to_s.upcase == request["REQUEST_METHOD"] : true
  end
end
describe RouteRequestSpecification do
  let(:sut) { RouteRequestSpecification.new  }

  context "when matching a uri path" do
    before { sut.handles(:uri => /^\/products$/) }

    it "should match when given the proper uri" do
      request = { "REQUEST_PATH" => '/products'}
      sut.matches(request).should be_true
    end
    it "should not match a uri for a different path" do
      request = { "REQUEST_PATH" => '/products/1'}
      sut.matches(request).should be_false
    end
  end
  context "when matching a path and a verb" do
    before { sut.handles(:uri => /posters/, :verb => :PUT) }

    it "should match when given the proper request" do
      request = { "REQUEST_PATH" => '/posters', "REQUEST_METHOD" => "PUT" }
      sut.matches(request).should be_true
    end
    it "should not match if the uri is incorrect" do
      request = { "REQUEST_PATH" => '/lamas', "REQUEST_METHOD" => "PUT" }
      sut.matches(request).should be_false
    end
    it "should not match if the verb is incorrect" do
      request = { "REQUEST_PATH" => '/posters', "REQUEST_METHOD" => "GET" }
      sut.matches(request).should be_false
    end
  end
  context "when matching a route with an id" do
    before :each do
      sut.handles(:uri => /^\/products\/[0-9]+$/)
    end
    it "should match when given a proper route" do
      request = { "REQUEST_PATH" => '/products/100' }
      sut.matches(request).should be_true
    end
    it "should not match other routes" do
      request = { "REQUEST_PATH" => '/products' }
      sut.matches(request).should be_false
    end
  end
end
