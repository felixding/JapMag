# Introduction

JapMag is a collection of frequently-used Rails controller methods and helpers.

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
