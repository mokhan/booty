require 'rack'

class WebRequest
  def initialize(raw_request)
    @request = Rack::Request.new(raw_request)
  end

  def payload
    convert_hash(@request.params)
  end

  private

  def convert_hash(hash)
    Hash[ hash.map { |key, value| [key.to_sym, value.is_a?(Hash) ? convert_hash(value) : value] } ]
  end
end
