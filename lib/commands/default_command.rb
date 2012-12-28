class DefaultCommand
  def run_against(request)
    [404, {"Content-Type" => "text/html"}, ["Oops... I couldn't find the page you were looking for! #{Time.now}"]]
  end
end
