module JapMag
  VERSION = "0.0.3"
  
  # i18N
  def _ key, options={}
    key = (key[0] == "/") ? key.gsub("/", "") : "#{params[:controller]}.#{params[:action]}.#{key}"
    t(key, options)
  end
  
  def self.included base
    base.helper_method :_
  end
  
  class Engine < Rails::Engine
  end
end
