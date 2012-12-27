require "rubygems"
require "rack"

class FrontController
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hello world!"]]
  end
end

Rack::Handler::Mongrel.run FrontController.new, :Port => 9292
