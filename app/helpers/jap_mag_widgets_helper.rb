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

  def get_wrapper_class
    c = []
    c << controller.action_name

    c.collect{|e| e.titleize.gsub(/\s/, "")}.join " "
  end

  def title *titles
    seperator = " - "

    default_options = {sitename: _("/logo")}
    options = titles.last.is_a?(Hash) ? titles.pop : {}
    options = default_options.merge(options)
    page_title = page_title_for_return = titles.join(seperator)
    page_title = options[:sitename] + seperator + page_title_for_return if not options[:sitename].blank?

    content_for :title, page_title

    page_title_for_return
  end

  def paginator collections, options = {}
    will_paginate collections, options
  end

  def last_deployed_at
    file = File.join("tmp", "restart.txt")
    File.exists?(file) ? File.atime(file) : nil
  end

  def bootstrap_menu links
    links.collect do |link|
      klass = []
      klass << link[:klass] if link[:klass]
      klass << "last-child" if link == links.last

      if (link[:controller_action].is_a?(Array) and current_controller_action_in?(*link[:controller_action])) \
        or (current_controller_action_in?(link[:controller_action]))
        klass << "active"
      end

      klass = klass.empty? ? nil : klass.join(" ")

      content_tag :li, class: klass do
        link_to link[:text], link[:path], link[:html_options]
      end
    end.join.html_safe
  end

  def bootstrap_scope_button scopes, options = {}
    content_tag :ul, class: "nav-tabs simple-tabs" do
      scopes.collect do |scope|
        url = eval("#{options[:path].to_s}(scope: :#{scope[:key]})")
        current = ((params[:scope] == scope[:key].to_s) or (scope[:default] and scope[:default] == true and params[:scope].blank?))
        link = link_to("#{content_tag(:span, scope[:text])} (#{scope[:count]})".html_safe, url, class: 'nav-link')
        klass = %w(nav-item)
        klass << :active if current

        concat content_tag(:li, link, class: klass.join(' '))
      end
    end
  end

  def bootstrap_button_group checkbox, id = nil, status = nil, default = nil
    status ||= %w(turned_on turned_off)
    default ||= "turned_off"

    content_tag :div, "id" => id, "class" => "bootstrap-toggle" do
      buttons = content_tag :div, "class" => "btn-group", "data-toggle" => "buttons-radio" do
        status.collect do |s|
          content_tag :button, "type" => "button", "class" => "btn btn-default #{s}#{" active" if s == default}", "data-status" => s do
            _("/page.my.pac.status.#{s}")
          end
        end.join.html_safe
      end

      buttons + checkbox
    end
  end

  def bootstrap_stacked_progress_bar percent, options = {}
    klass = if percent < 50
              :success
            elsif percent >= 50 and percent < 80
              :warning
            else
              :danger
            end

    #percent = "#{percent * 100}%"
    options[:precision] ||= 2
    percent = number_to_percentage percent, options

    opts_for_container = {class: :progress}
    if options[:tooltip]
      placement = options[:tooltip][:placement] || "top"
      opts_for_container.merge!("data-toggle" => "tooltip", "data-placement" => placement, title: options[:tooltip][:title])
    end

    content_tag :div, opts_for_container do
      content_tag :div, class: "progress-bar progress-bar-#{klass}", role: :progressbar, style: "width: #{percent}" do
        percent
      end
    end
  end

  def link_to_external text, link, options = {}
    options.merge!(target: :_blank)

    if options[:anonymous]
      link = "http://anonym.to/?#{link}"
      options.delete(:anonymous)
    end

    link_to "#{text}#{fa_icon "external-link-alt", type: :fas}".html_safe, link, options
  end

  def input_for_selection text
    (content_tag :input, nil, value: text, size: text.length, class: "form-input for-selection").html_safe
  end

  #
  # call to action
  #
  def cta text, url, options = {}
    klass = %w(button button-rounded button-caution)
    klass << options[:class] if options[:class].present?
    options[:class] = klass.join(" ")

    link_to text, url, options
  end

  def cta_params options = {}
    {data: {disable_with: _("/actions.wait")}, class: "button button-rounded button-caution"}.merge options
  end

  def long_date date
    I18n.l date, format: :long
  end


  def short_date date
    I18n.l date, format: :short
  end

  def retina_image_tag name_at_1x, options = {}
    # webp for Chrome
    if options[:webp]
      name_at_1x = name_at_1x.gsub /\.[a-zA-Z]+$/, '.webp'

      options.delete :webp
    end

    # retina
    name_at_2x = name_at_1x.gsub /\.\w+$/, "@2x\\0"

    # i18n
    if options[:i18n]
      name_at_1x = name_at_1x.gsub /\.[a-zA-Z]+$/, ".#{I18n.locale}\\0"
      name_at_2x = name_at_2x.gsub /\.[a-zA-Z]+$/, ".#{I18n.locale}\\0"

      options.delete :i18n
    end

    # HTML 5 specific tag attributes
    srcset = "#{asset_path(name_at_1x)} 1x, #{asset_path(name_at_2x)} 2x"
    options = options.merge(srcset: srcset)

    image_tag name_at_1x, options
  end

  protected

  def current_template
    File.basename(lookup_context.find_all(params[:action], params[:controller]).first.inspect)
  end
end
