require 'erb'

module Booty
  class ERBTemplate
    def initialize(content)
      @content = content
    end

    def expand(binding)
      ERB.new(@content).result(binding).chomp.gsub(/\n/, '')
    end
  end
end
