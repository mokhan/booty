require 'erb'
require 'ostruct'
require 'expose_binding_behaviour'

module Booty
  class DefaultCommand
    def run_against(request)
      payload = OpenStruct.new(:name => "BINDING", :time => Time.now)
      payload.extend(ExposeBindingBehaviour)
      [404, {"Content-Type" => "text/html"}, [ERB.new(File.read('lib/views/404.html.erb')).result(payload.get_binder)]]
    end
  end
end
