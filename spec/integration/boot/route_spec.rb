require "spec_helper"

module Booty
  describe "routing" do
    let(:registry) { CommandRegistry.new }
    let(:container) { Booty::Container.new }

    before :each do
      BootstrapContainer.new(container).run
      BootstrapRouting.new(registry, container).run
    end

    context "dashboard" do
      it "should route to the dashboard" do
        route_for({ :path => "/", :method => :GET }).should be_instance_of(Booty::Dashboard::IndexCommand)
      end
    end
    context "products" do
      it "should route to the index" do
        route_for({ :path => "/products", :method => :GET }).should be_instance_of(Booty::Products::IndexCommand)
      end
      it "should route to the new page" do
        route_for({ :path => "/products/new", :method => :GET }).should be_instance_of(Booty::Products::NewCommand)
      end
      it "should route to the create command" do
        route_for({ :path => "/products", :method => :POST }).should be_instance_of(Booty::Products::CreateCommand)
      end
      it "should route to the show command" do
        route_for({ :path => "/products/1", :method => :GET }).should be_instance_of(Booty::Products::ShowCommand)
      end
    end
    context "sessions" do
      it "should route to the new page" do
        route_for({ :path => "/sessions/new", :method => :GET}).should be_instance_of(Booty::Sessions::NewCommand)
      end
    end

    it "should route to the 404 handler" do
      route_for({ :path => "/blah/blah" }).should be_instance_of(Booty::DefaultCommand)
    end

    def command_for(request)
      registry.command_for(request).command
    end

    def route_for(options)
      command_for( { "REQUEST_PATH" => options[:path], "REQUEST_METHOD" => options[:method].to_s })
    end
  end
end
