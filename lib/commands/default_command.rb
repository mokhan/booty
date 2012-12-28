require 'erb'

class DefaultCommand
  def run_against(request)
    time = Time.now
    name = "MO"
    [404, {"Content-Type" => "text/html"}, [ERB.new(File.read('lib/views/404.html.erb')).result(binding)]]
  end
end
