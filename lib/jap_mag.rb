module JapMag
  # i18N
  def _ key, options={}
    # for absolute pathes /
    if (key[0] == "/")
      key = key.sub("/", "")

    # for all other cases
    else
      key = "#{params[:controller]}.#{params[:action]}.#{key}"
    end

    t(key, options)
  end

  #
  # the args can be one of the following:
  #
  # String: "page#index"
  # Array: %w(page#index page#intro)
  # multiple arguments: "page#index", "page#intro"
  #
  def current_controller_action_in?(*args)
    controller = params["controller"]
    action = params["action"]

    if args.size == 1
      if args.first.is_a?(Array)
        arguments = args.first.split(" ").first
      elsif args.first.is_a?(String)
        if args.first.split(" ").size > 1
          arguments = args.first.split(" ")
        else
          arguments = args
        end
      end
    else
      arguments = args
    end

    #raise arguments.inspect

    arguments.each do |element|
      if element.include?("#")
        array = element.match(/([a-z\-\_\/]*)#([a-z\-\_]*)/).to_a
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
