class JapMagApplicationController < ActionController::Base
  def current_controller_action_in?(*args)
    args.each do |element|
      if element.include?("#")
        array = element.match(/([a-z\-\_]*)#([a-z\-\_]*)/).to_a
        c, a = array[1], array[2]
        return true if controller.controller_name == c && controller.action_name == a
      else
        return true if controller.controller_name == element
      end
    end
  
    false
  end
  
  helper_method :current_controller_action_in?
end