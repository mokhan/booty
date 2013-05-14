require 'erb'

module Booty
  class ERBTemplate
    def initialize(content)
      @content = content
    end

    def expand(binding)
      ERB.new(@content).result(binding)
    end
  end
end
