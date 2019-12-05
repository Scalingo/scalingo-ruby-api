require 'test_helper'

class ConnectionTest < BaseTestCase
  test 'missing token' do
    Scalingo.token = nil
    assert_raise(Scalingo::MissingToken) do
      client = Scalingo::Client.new(region: 'test-1')
      client.apps.all
    end
  end
end
