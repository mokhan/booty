require 'erb'
require 'expose_binding_behaviour'

module Booty
  class ViewEngine

    def initialize(defaults = { :master => "master.html.erb"})
      @defaults = defaults
    end

    def render(options = {})
      combined_options = @defaults.merge(options)
      erb_from(combined_options[:master], OpenStruct.new(:content => erb_from(combined_options[:template], combined_options[:model])))
    end

    private 

    def binding_for(model)
      model.extend(ExposeBindingBehaviour)
      model.get_binder
    end

    def read_from(file)
      File.read(File.join(@defaults[:root_path], file))
    end

    def erb_from(file, model)
      template = ERB.new(read_from(file))
      template.result(binding_for(model)).chomp
    end
  end
end
