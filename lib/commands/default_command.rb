class DefaultCommand
  def run_against(request)
    [200, {"Content-Type" => "text/html"}, ["Hello world! #{Time.now}"]]
  end
end
