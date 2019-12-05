require 'bundler/setup'
require 'simplecov'
require 'jwt'
require 'pry'

SimpleCov.configure do
  add_filter '/test/'
end
SimpleCov.start if ENV['COVERAGE']

require 'minitest/autorun'
require 'webmock/minitest'
require 'active_support'
ActiveSupport.test_order = :random

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

  def auth_endpoint_uri
    Scalingo.auth_endpoint
  end

  def url_with_basic_auth(url)
    return url.split('://').join("://:#{Scalingo.token}@")
  end

  def stub(method, path, auth_api: false, region: 'test-1')
    uri = "https://api.#{region}.scalingo.com"
    uri = auth_endpoint_uri if auth_api
    case path
    when String
      uri = url_with_basic_auth(uri) if path == '/tokens/exchange'
      return stub_request(method, "#{uri}#{path}")
    when Regexp
      return stub_request(method, /#{Regexp.quote(uri)}#{path}/)
    end
  end

  def stub_regions(region)
    stub(
      :get, '/regions', auth_api: true,
    ).to_return(
      status: 200,
      headers: {
        'Content-Type' => 'application/json',
      },
      body: { regions: [
        {
          name: region,
          api: "https://api.#{region}.scalingo.com",
          database_api: "https://db-api.#{region}.scalingo.com",
        },
      ] }.to_json,
    )
  end

  def stub_token_exchange
    stub(
      :post, '/tokens/exchange', auth_api: true,
    ).to_return(
      status: 200,
      headers: {
        'Content-Type' => 'application/json',
      },
      body: { token: generate_test_jwt }.to_json,
    )
  end

  def generate_test_jwt
    payload = {
      iss: 'Scalingo Test', iat: Time.current.utc.to_i, uuid: SecureRandom.uuid,
      rnd: SecureRandom.hex, exp: (Time.now.utc.to_i + 3600),
    }
    token = JWT.encode payload, '0' * 100, 'HS512'
    return token
  end
end

