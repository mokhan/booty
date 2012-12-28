require 'erb'

class DefaultCommand
  def run_against(request)

    time = Time.now
    name = "MO"
    template = ERB.new <<-EOF
      Oops... I couldn't find the page you were looking for! <%= time %>

      <%= name %>
    EOF

    #[404, {"Content-Type" => "text/html"}, ["Oops... I couldn't find the page you were looking for! #{Time.now}"]]
    [404, {"Content-Type" => "text/html"}, [template.result(binding)]]
  end
end
