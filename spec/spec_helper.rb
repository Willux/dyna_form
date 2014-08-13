require 'bundler/setup'
Bundler.setup

require 'active_support/all'
require 'dyna_form' # and any other gems you need
require 'support/admin_user'
require 'support/test_form'
require 'support/test_form_again'
require 'ostruct'

RSpec.configure do |config|
  # some (optional) config here
  # end
end
