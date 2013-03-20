require 'image'
require 'stylesheet'
require 'javascript'

module Booty
  module Assets
    class AssetCommand
      def initialize(assets = [ Javascript.new, Stylesheet.new, Image.new ])
        @assets = assets
      end
      def matches(request)
        @assets.any? { |asset| asset.matches(request) }
      end
      def run(request)
        asset = @assets.find { |a| a.matches(request) }
        asset.run(request["REQUEST_PATH"])
      end
    end
  end
end
