# JapMag

JapMag is the design language created by Felix Ding in the spring of 2012. The essential idea behind JapMag is Japanese Minimalism. It focuses on content itself, and aims to solve information overload. On interaction design, JapMag advocates a flat information architecutre, a one-task-one-step method and a natural content flow on each page. Visually, JapMag stresses typography, whitespace and uses graphical elements as little as possible. Technically, JapMag avoids using Javascript, or overriding browsers' default behaviors.

This gem helps designers start a project that follows JapMag. It consists of several CSS definations, Rails helpers and view templates.

## Installation

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
     
## Usage

Documentation is on the way. Stay tuned!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
