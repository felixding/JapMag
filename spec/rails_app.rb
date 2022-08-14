class RailsApp
  include JapMag

  attr :params, true

  def initialize params
    @params = params
  end
end
