require 'erb'
require 'expose_binding_behaviour'

module Booty
  class ViewEngine

    def initialize(root_path = 'lib/commands', master: 'master.html.erb' )
      @root_path = root_path
      @master = master
    end

    def render(options = {})
      model = options[:model]
      dto = OpenStruct.new(:model => model)
      html = erb_from(options[:template], dto).gsub(/\n/, '')
      dto.content = html
      erb_from(@master, dto)
    end

    private

    def binding_for(model)
      model.extend(ExposeBindingBehaviour)
      model.get_binder
    end

    def read_from(file)
      File.read(File.join(@root_path, file))
    end

    def erb_from(file, model)
      template = ERB.new(read_from(file))
      binding = binding_for(model)
      p "rendering #{file} with #{model}"
      template.result(binding).chomp
    end
  end
end
