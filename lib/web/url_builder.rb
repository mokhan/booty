module Booty
  class UrlBuilder
    def initialize(url)
      @url = url
      @params = Hash.new()
    end
    def append(key, value)
      @params[key] = [] unless @params.has_key?(key)
      @params[key].push(CGI.escape(value))
    end
    def build
      result = @url.clone
      result << "?" if @params.keys.any?
      @params.keys.each_with_index do |key, i|
        result << "&" unless i == 0
        result << "#{key}="
        @params[key].each_with_index do |value,index|
          result << "+" unless index == 0
          result << value.to_s
        end
      end
      result
    end
  end
end
