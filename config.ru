require "rubygems"
require "rack"

Dir.glob("lib/**/*.rb").each { |x| $:.unshift(File.dirname(x)) }
require 'front_controller'


#class FrontController
  #def call(env)
    #[200, {"Content-Type" => "text/html"}, ["Hello world!"]]
  #end
#end

Rack::Handler::Mongrel.run FrontController.new, :Port => 9292
