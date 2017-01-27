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

  test 'respond_to' do
    assert !Scalingo.methods.include?(:get)
    assert Scalingo.respond_to?(:get)
  end

  test 'method_missing' do
    stub(:get, '').to_return(status: 200)
    assert Scalingo.client.get('') == Scalingo.get('')
  end
end

