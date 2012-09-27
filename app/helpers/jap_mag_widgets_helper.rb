module JapMagWidgetsHelper
  
  def is_mobile_device?
    mobile_user_agents = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
    request.user_agent.to_s.downcase =~ Regexp.new(mobile_user_agents)
  end
  
  def get_body_class
    c = []
    c << controller.controller_name
    c << "mobile" if is_mobile_device?
    
    c.collect{|e| e.titleize.gsub(/\s/, "")}.join " "
  end
  
  def get_body_id
    content_for(:id).to_s.titleize.gsub(/\s/, "") unless content_for(:id).blank?
  end

  #
  # navigation helper
  # by Felix
  #
  # the helper matches params with request.request_uri
  #
  # example:
  # sections = {
  #		'radio'=>{:title => 'Station', :url => radio_path},
  #		'edit_station'=>{:url => 'Radio', :url => edit_station_path}
  #	}
  # options = {
  #    :id => 'test_menu'
  #    :current => 'current'
  # }
  # outputs:
  # <ul id="test_menu">
  #   <li><a href="/station">Station</a></li>
  #   <li class="current"><a href="/radio/">Radio</a></li>
  # </ul>
  #:title
  def menu(sections, options=nil)
    items = Array.new

    # default options
    options ||= Hash.new
    options[:id] ||= nil
    options[:class] ||= nil
    options[:current] ||= 'current' # jquery ui tabs plugin needs the later one

    sections.each do |section|
      klass = section[:current] ? "#{options[:current]} #{section[:class]}".strip : section[:class]
      items << content_tag(:li, link_to(section[:title], section[:url], :class => klass))   
    end

    return content_tag :ul, :id => options[:id], :class => options[:class] do
      items.collect {|item| concat(item)}
    end
  end

  def clearfix options={}
    opt = {:class => " clearfix"}
    options[:class] += opt[:class] if options[:class]
    (options[:class] || opt[:class]).strip!
    opt = opt.merge(options)
    content_tag(:div, nil, opt)
  end

  def link_to_user(user, options={})

    default_options = {
      :href => user,
      :avatar => false,
      :title => user.name,
      :class => ""
    }

    options = default_options.merge(options)

    if options[:avatar]
      return unless user.avatar?

      text = image_tag(user.avatar.url(options[:avatar]), :alt => user.name, :class => "avatar")

      options[:class] += " avatar".strip
    else
      text = user.name
    end

    #raise url_for(user)#user_path(:subdomain => "aaa").inspect
    link_to(text, options[:href], :title => options[:title], :class => options[:class])
  end

  def title(*titles)
    seperator = " - "

    default_options = {:sitename => true}
    options = titles.last.is_a?(Hash) ? titles.pop : {}
    options = default_options.merge(options)

    page_title = page_title_for_return = titles.join(seperator)
    page_title = t("logo") + seperator + page_title_for_return if options[:sitename]

    content_for(:title, page_title)

    page_title_for_return
  end

  def random_disable_with_status
    status = [
      "Just a moment",
      "Let's stay together",
      "On the highway to hell",
      "Don't worry baby",
      "Let it be",
      "Getting you away from here",
      "Let's get it started",
      "It's now or never"
    ]

    status.shuffle.first + "..."
  end

  #
  # call to action
  #
  def cta text, url, html_options={}

    html_options[:class] = (html_options[:class].to_s + " cta").strip

    link_to content_tag(:span, text), url, html_options
  end

  #
  # paginator
  #
  def paginator(collections, options={})
    will_paginate collections, options
  end

  def time_difference time
    "#{distance_of_time_in_words(time, Time.now, true)} ago" if time
  end
  
  def current_or_null(condition)
    condition ? "current" : nil
  end

  def scope_button scopes, options={}
    content_tag :ul, class: :scopes do
      scopes.collect do |scope|
        count = options[:count][scope[:key]]
        url = eval("#{options[:path].to_s}(scope: :#{scope[:key]})")
        current = ((params[:scope] == scope[:key].to_s) or (scope[:default] and params[:scope].blank?))

        concat content_tag(:li, link_to("#{content_tag(:span, scope[:text])} (#{count})".html_safe, url, class: current_or_null(current)))
      end
    end
  end
  
  def last_deployed_at
    file = File.join("tmp", "restart.txt")
    File.exists?(file) ? File.atime(file) : nil
  end
  
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

  protected
  
  def current_template
    File.basename(lookup_context.find_all(params[:action], params[:controller]).first.inspect)
  end
end