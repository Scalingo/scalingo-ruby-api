require 'test_helper'

class ScalingoTest < BaseTestCase
  test 'configure' do
    Scalingo.configure do |config|
      config.token = 'CONFIGURE_TEST'
    end
    assert_equal 'CONFIGURE_TEST', Scalingo.token
  end

  test 'client' do
    assert_equal Scalingo::Client, Scalingo.client.class
  end
end
