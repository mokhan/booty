require 'rack'

class WebRequest
  def initialize(raw_request)
    @request = Rack::Request.new(raw_request)
  end
  def payload
    Hash[@request.params.map { |key, value| [key.to_sym, value] }]
  end
end
