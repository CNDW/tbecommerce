require 'ffaker'
require 'spree/testing_support/factories'

Dir["#{File.dirname(__FILE__)}/factories/**"].each do |f|
  load File.expand_path(f)
end
