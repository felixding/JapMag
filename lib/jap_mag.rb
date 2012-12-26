module JapMag
  # i18N
  def _ key, options={}
    # for absolute pathes /
    if (key[0] == "/")
      key = key.gsub("/", "")
      
    # for internal references >>/
    elsif (key[0, 3] == ">>/")
      key = key.gsub(">>/", "")
    
    # for all other cases  
    else
      key = "#{params[:controller]}.#{params[:action]}.#{key}"
    end

    t(key, options)
  end
  
  def current_controller_action_in?(*args)
    controller = params["controller"]
    action = params["action"]

    args.each do |element|
      if element.include?("#")
        array = element.match(/([a-z\-\_]*)#([a-z\-\_]*)/).to_a
        c, a = array[1], array[2]
        return true if controller == c && action == a
      else
        return true if controller == element
      end
    end
  
    false
  end
  
  def self.included base
    base.helper_method :_
    base.helper_method :current_controller_action_in?
  end
  
  class Engine < Rails::Engine
  end
end
