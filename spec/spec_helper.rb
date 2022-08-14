require 'bundler/setup'
Bundler.setup

RSpec.configure do |config|
end

require 'rails_engine'
require_relative '../lib/jap_mag'
require_relative 'jap_mag'
require 'rails_app'
