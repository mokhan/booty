require 'erb'
require 'expose_binding_behaviour'

module Booty
  class TemplateExpansion
    def initialize(root_path)
      @root_path = root_path
    end
    def expand(file, model)
      template = ERB.new(read_from(file))
      binding = binding_for(model)
      template.result(binding).chomp.gsub(/\n/, '')
    end
    private
    def read_from(file)
      File.read(File.join(@root_path, file))
    end
    def binding_for(model)
      model.extend(ExposeBindingBehaviour)
      model.get_binder
    end
  end
end
