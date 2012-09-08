# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jap_mag/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Felix Ding"]
  gem.email         = ["felixding@gmail.com"]
  gem.description   = %q{JapMag is the design language created by Felix Ding. This gem helps designers start a project that follows JapMag.}
  gem.summary       = "jap_mag-#{gem.version}"
  gem.homepage      = "http://dingyu.me"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jap_mag"
  gem.require_paths = ["lib"]
  gem.version       = JapMag::VERSION
end
