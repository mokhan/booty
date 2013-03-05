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
        command_for({ "REQUEST_PATH" => "/", "REQUEST_METHOD" => "GET" }).should be_instance_of(Booty::Dashboard::IndexCommand)
      end
    end
    context "products" do
      it "should route to the index" do
        command_for({ "REQUEST_PATH" => "/products", "REQUEST_METHOD" => "GET" }).should be_instance_of(Booty::Products::IndexCommand)
      end
      it "should route to the new page" do
        command_for({ "REQUEST_PATH" => "/products/new", "REQUEST_METHOD" => "GET" }).should be_instance_of(Booty::Products::NewCommand)
      end
      it "should route to the create command" do
        command_for({ "REQUEST_PATH" => "/products", "REQUEST_METHOD" => "POST" }).should be_instance_of(Booty::Products::CreateCommand)
      end
      it "should route to the show command" do
        command_for({ "REQUEST_PATH" => "/products/1", "REQUEST_METHOD" => "GET" }).should be_instance_of(Booty::Products::ShowCommand)
      end
    end
    context "sessions" do
      it "should route to the new page" do
        command_for({ "REQUEST_PATH" => "/sessions/new", "REQUEST_METHOD" => "GET"}).should be_instance_of(Booty::Sessions::NewCommand)
      end
    end

    it "should route to the 404 handler" do
      command_for({ "REQUEST_PATH" => "/blah/blah" }).should be_instance_of(Booty::DefaultCommand)
    end

    def command_for(request)
      registry.command_for(request).command
    end
  end
end
