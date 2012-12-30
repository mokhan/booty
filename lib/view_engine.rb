require 'erb'
require 'expose_binding_behaviour'

module Booty
  class ViewEngine
    def initialize(defaults = {})
      @defaults = defaults
    end
    def render(options = {})
      filename = File.join(@defaults[:root_path], options[:template])
      ERB.new(File.read(filename)).result(model_from(options).get_binder).chomp
    end
    private 
    def model_from(options)
      model = options[:model]
      model.extend(ExposeBindingBehaviour)
      model
    end
  end
end
