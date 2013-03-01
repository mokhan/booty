require "spec_helper"

describe DatabaseConfiguration do
  let(:sut) { DatabaseConfiguration.new }

  context "when configuring a new connection" do
    let(:connection) { fake }
    let(:connection_string) { build_connection_string }

    before :each do
      sut.configure(connection)
    end

    it "should supply the proper settings" do
      connection.should have_received(:connect, connection_string)
    end

    def load_all_configuration
      YAML.load_file(File.join(File.dirname(__FILE__),'../../../db/configuration.yml'))
    end

    def build_connection_string
      configuration = load_all_configuration[ENV["BOOTY_ENV"] || "test"]
      "postgres://#{configuration['username']}:#{configuration['password']}@#{configuration['host']}/#{configuration['database']}"
    end

  end
end
