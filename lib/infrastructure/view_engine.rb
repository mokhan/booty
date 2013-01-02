require 'erb'
require 'expose_binding_behaviour'

module Booty
  class ViewEngine
    def initialize(defaults = {})
      @defaults = defaults
    end
    def render(options = {})
      html = ERB.new(read_from_file(options[:template])).result(binding_for(options[:model])).chomp
      ERB.new(read_from_file(@defaults[:master])).result(binding_for(OpenStruct.new(:content => html))).chomp
    end

    private 

    def binding_for(model)
      model.extend(ExposeBindingBehaviour)
      model.get_binder
    end

    def read_from_file(template)
      File.read(File.join(@defaults[:root_path], template))
    end
  end
end
