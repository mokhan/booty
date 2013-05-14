require "spec_helper"
RSpec::Matchers.define :route_to do |expected|
  match do |actual|
    actual.instance_of? expected
  end
end

module Booty
  describe "routing" do
    let(:registry) { RouteRegistry.new }
    let(:container) { Booty::Container.new }

    before :each do
      BootstrapContainer.new(container).run
      BootstrapRouting.new(registry, container).run
    end

    context "dashboard" do
      it "should route to the dashboard" do
        request_to({ :path => "/", :method => :GET }).should route_to(Booty::Dashboard::IndexCommand)
      end
    end
    context "products" do
      it "should route to the index" do
        request_to({ :path => "/products", :method => :GET }).should route_to(Booty::Products::IndexCommand)
      end
      it "should route to the new page" do
        request_to({ :path => "/products/new", :method => :GET }).should route_to(Booty::Products::NewCommand)
      end
      it "should route to the create command" do
        request_to({ :path => "/products", :method => :POST }).should route_to(Booty::Products::CreateCommand)
      end
      it "should route to the show command" do
        request_to({ :path => "/products/1", :method => :GET }).should route_to(Booty::Products::ShowCommand)
      end
    end
    context "sessions" do
      it "should route to the new page" do
        request_to({ :path => "/sessions/new", :method => :GET}).should route_to(Booty::Sessions::NewCommand)
      end

      it "should route to the new oauth page" do
        request_to({ :path => "/sessions/new/oauth", :method => :GET}).should route_to(Booty::Sessions::OAuth::NewCommand)
      end
    end

    it "should route to the 404 handler" do
      request_to({ :path => "/blah/blah" }).should route_to(Booty::DefaultCommand)
    end

    def command_for(request)
      registry.route_for(request).command
    end

    def request_to(options)
      command_for( { "REQUEST_PATH" => options[:path], "REQUEST_METHOD" => options[:method].to_s })
    end
  end
end
