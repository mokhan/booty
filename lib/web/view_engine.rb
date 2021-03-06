module Booty
  class ViewEngine
    def initialize(root_path: 'lib/commands', master: 'master', template_expander: TemplateExpansion.new(root_path))
      @root_path = root_path
      @master = "#{master}.html.erb"
      @template_expander = template_expander
    end

    def render(template: '', model: OpenStruct.new )
      dto = OpenStruct.new(:model => model)
      dto.content = @template_expander.expand("#{template}.html.erb", dto)
      @template_expander.expand(@master, dto)
    end
  end
end
