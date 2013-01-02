require 'erb'
require 'expose_binding_behaviour'

module Booty
  class ViewEngine
    def initialize(defaults = {})
      @defaults = defaults
    end
    def render(options = {})
      html = ERB.new(read_from_file(options[:template])).result(model_from(options).get_binder).chomp
      master_model = OpenStruct.new(:content => html)
      master_model.extend(ExposeBindingBehaviour)

      ERB.new(read_from_file(@defaults[:master])).result(master_model.get_binder).chomp
    end

    private 

    def model_from(options)
      model = options[:model]
      model.extend(ExposeBindingBehaviour)
      model
    end

    def read_from_file(template)
      File.read(File.join(@defaults[:root_path], template))
    end
  end
end
