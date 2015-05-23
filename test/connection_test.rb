require 'test_helper'

class ConnectionTest < BaseTestCase
  test 'missing token' do
    Scalingo.token = nil
    assert_raise(Scalingo::MissingToken) do
      Scalingo.apps.all
    end
  end

  test 'parse_json' do
    stub(:get, 'parse_json').to_return(body: {hello: :world}.to_json)
    result = Scalingo.get('parse_json')
    assert_equal({"hello" => "world"}, result)
  end

  test 'parse_json false' do
    Scalingo.parse_json = false
    stub(:get, 'parse_json').to_return(body: {hello: :world}.to_json)
    result = Scalingo.get('parse_json')
    assert_equal('{"hello":"world"}', result)
  end
end

