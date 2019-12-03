require 'test_helper'

class ConnectionTest < BaseTestCase
  test 'missing token' do
    Scalingo.token = nil
    assert_raise(Scalingo::MissingToken) do
      client = Scalingo::Client.new(region: 'test-1')
      client.apps.all
    end
  end

  test 'parse_json' do
    client = Scalingo::Client.new(region: 'test-1')
    stub_token_exchange
    stub_regions('test-1')

    stub(:get, '/parse_json').to_return(body: { hello: :world }.to_json)
    result = client.get('/parse_json')
    assert_equal({ 'hello' => 'world' }, result)
  end

  test 'parse_json false' do
    client = Scalingo::Client.new(region: 'test-1', parse_json: false)
    stub_token_exchange
    stub_regions('test-1')

    stub(:get, '/parse_json').to_return(body: { hello: :world }.to_json)
    result = client.get('/parse_json')
    assert_equal('{"hello":"world"}', result)
  end
end
