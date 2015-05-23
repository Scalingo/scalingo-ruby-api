require 'bundler/setup'
require 'simplecov'
require 'pry'

SimpleCov.configure do
  add_filter '/test/'
end
SimpleCov.start if ENV['COVERAGE']

require 'minitest/autorun'
require 'webmock/minitest'
require 'active_support/test_case'

require File.expand_path("../../lib/scalingo", __FILE__)

WebMock.disable_net_connect!

class BaseTestCase < ActiveSupport::TestCase
  setup do
    Scalingo.reset
    Scalingo.token = 'EXAMPLE_TOKEN'
  end

  teardown do
    WebMock.reset!
  end

  def endpoint_uri
    Scalingo.endpoint.split('://').join("://:#{Scalingo.token}@")
  end

  def stub(method, path)
    case path
    when String
      stub_request(method, "#{endpoint_uri}#{path}")
    when Regexp
      stub_request(method, /#{Regexp.quote(endpoint_uri)}#{path}/)
    end
  end
end

