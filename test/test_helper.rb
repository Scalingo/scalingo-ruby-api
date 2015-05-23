require 'bundler/setup'
require 'simplecov'

SimpleCov.configure do
  add_filter '/test/'
end
SimpleCov.start if ENV['COVERAGE']

require 'minitest/autorun'
require 'webmock/minitest'
require 'active_support/test_case'

require File.expand_path("../../lib/scalingo", __FILE__)

WebMock.disable_net_connect!

class BaseTest < ActiveSupport::TestCase
end

