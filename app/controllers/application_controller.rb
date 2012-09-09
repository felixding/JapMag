class ApplicationController < ActionController::Base

  # i18N
  def _ key, options={}
    key = (key[0] == "/") ? key.gsub("/", "") : "#{params[:controller]}.#{params[:action]}.#{key}"
    t(key, options)
  end

  helper_method :_

end