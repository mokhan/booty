class RequestSpecification
  def initialize(route)
    @options = route
  end
  def matches(request)
    matches_path(request) && matches_verb(request)
  end
  private
  def matches_path(request)
    @options[:uri].match request["REQUEST_PATH"]
  end
  def matches_verb(request)
    @options.has_key?(:verb) ? @options[:verb].to_s.upcase == request["REQUEST_METHOD"] : true
  end
end
