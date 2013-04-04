module Booty
  class ViewEngine
    def initialize(root_path: 'lib/commands', master: 'master.html.erb', template_expander: TemplateExpansion.new(root_path))
      @root_path = root_path
      @master = master
      @template_expander = template_expander
    end

    def render(template: '', model: OpenStruct.new )
      dto = OpenStruct.new(:model => model)
      html = @template_expander.expand(template, dto).gsub(/\n/, '')
      dto.content = html
      @template_expander.expand(@master, dto)
    end
  end
end
