require "spec_helper"

module Booty
  describe "routing" do
    let(:registry) { CommandRegistry.new }
    let(:container) { Booty::Container.new }

    before :each do
      BootstrapContainer.new(container).run
      BootstrapRouting.new(registry, container).run
    end

    it "should route to the dashboard" do
      command_for({ "REQUEST_PATH" => "/", "REQUEST_METHOD" => "GET" }).should be_instance_of(Booty::Dashboard::IndexCommand)
    end

    it "should route to the 404 handler" do
      command_for({ "REQUEST_PATH" => "/blah/blah" }).should be_instance_of(Booty::DefaultCommand)
    end

    def command_for(request)
      registry.command_for(request).command
    end
  end
end
