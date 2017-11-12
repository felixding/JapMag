# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jap_mag/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["DING Yu"]
  gem.email         = ["felixding@gmail.com"]
  gem.description   = %q{JapMag is a collection of frequently-used Rails controller methods and helpers.}
  gem.summary       = "jap_mag-#{gem.version}"
  gem.homepage      = "https://github.com/felixding/JapMag"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jap_mag"
  gem.require_paths = ["lib"]
  gem.version       = JapMag::VERSION

  gem.add_runtime_dependency :will_paginate
end
