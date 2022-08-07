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

  def current_locale
    params[:locale] || I18n.default_locale || extract_locale_from_accept_language_header
  end

  def extract_locale_from_accept_language_header
    if request.env and request.env['HTTP_ACCEPT_LANGUAGE']
      lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      lang = nil
    end

    lang == "zh" ? "zh-CN" : "en"
  end

  def current_path
    URI.encode(request.fullpath)
  end

  def current_url
    URI.encode(request.original_url)
  end

  #
  # the args can be one of the following:
  #
  # String: "page#index"
  # Array: %w(page#index page#intro)
  # multiple arguments: "page#index", "page#intro"
  #
  def current_controller_action_in?(*args)
    controller = params[:controller]
    action = params[:action]
    #raise args.inspect if args != 'homepage/page#index'

    args = args.first if args.size == 1 && args.first.is_a?(Array)

    args.each do |element|
      if element.to_s.include?("#")
        c, a = element.split('#')
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
    base.helper_method :current_locale
    base.helper_method :current_url
    base.helper_method :current_path
  end

  class Engine < Rails::Engine
  end
end
