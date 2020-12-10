# Introduction

JapMag is a collection of frequently-used Rails controller methods, helpers, Javascript functions and SASS mixins. It helps quickly bootstrap a Rails app.

For example, [current_controller_action_in?](https://github.com/felixding/JapMag/blob/master/lib/jap_mag.rb#L38) is a helper that checks if current request.controller and request.action match with a set of given rules. You can then for example show or hide certain things on your app depending if it matches or not. 

Another example is [retina_image_tag](https://github.com/felixding/JapMag/blob/master/app/helpers/jap_mag_widgets_helper.rb#L164) which can easily generate HTML `img` tags for Retina/Non-retina screens. It also helps you deal with localized images.

This project was first created in 2012.

## Installation & Usage

Please note JapMag only supports Rails 3+.

Add this line to your application's Gemfile:

    gem 'jap_mag', git: "git://github.com/felixding/JapMag.git"

And then execute:

    $ bundle

In your CSS manifest (application.css in default):

     *= require jap_mag

In your Javascript manifest (application.js in default):

	 //= require jquery
     //= require jquery_ujs
     //= require jap_mag

In your app/controllers/application_controll.rb, add

     include JapMag

For a new Rails app, delete app/views/layout/application.html.erb.

Done! Now start your Rails app and you will see a JapMag-powered website!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Code released under the [MIT License](https://opensource.org/licenses/MIT).
