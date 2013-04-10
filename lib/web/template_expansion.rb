require 'expose_binding_behaviour'
require "erb_template"

module Booty
  class TemplateExpansion
    def initialize(root_path)
      @root_path = root_path
    end

    def expand(file, model)
      template_for(file).expand(binding_for(model))
    end

    private

    def read_from(file)
      File.read(File.join(@root_path, file))
    end

    def binding_for(model)
      model.extend(ExposeBindingBehaviour)
      model.get_binder
    end

    def template_for(file)
      ERBTemplate.new(read_from(file))
    end
  end
end
