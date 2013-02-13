class Booty::Products::NewCommand < Booty::RouteCommand
  def initialize(view_engine)
    @view_engine = view_engine
  end

  def run(request)
    @view_engine.render(:template => 'products/new.html.erb')
  end
end
