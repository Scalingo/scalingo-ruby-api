require 'test_helper'

class RequestTest < BaseTestCase
  setup do
    @request = nil
    stub(:any, /.*/).to_return do |request|
      @request = OpenStruct.new(
        body: request.body,
        http_method: request.method,
        headers: request.headers,
        uri: request.uri,
        query: request.uri.query ? Hash[request.uri.query.split('&').map{|q| q.split('=')}] : {},
        path: request.uri.path[4..-1],
      )
      {status: 200}
    end
  end

  [:get, :delete].each do |sym|
    test "#{sym}" do
      Scalingo.public_send(sym, '')
      assert_equal sym, @request.http_method
      assert_equal({}, @request.query)
      assert_equal '', @request.path
      assert_equal nil, @request.body

      Scalingo.public_send(sym, 'hello')
      assert_equal sym, @request.http_method
      assert_equal({}, @request.query)
      assert_equal 'hello', @request.path
      assert_equal nil, @request.body

      Scalingo.public_send(sym, 'hello', {hello: :world})
      assert_equal sym, @request.http_method
      assert_equal({"hello" => "world"}, @request.query)
      assert_equal 'hello', @request.path
      assert_equal nil, @request.body
    end
  end

  [:post, :patch, :put].each do |sym|
    test "#{sym}" do
      Scalingo.public_send(sym, '')
      assert_equal sym, @request.http_method
      assert_equal({}, @request.query)
      assert_equal '', @request.path
      assert_equal '', @request.body

      Scalingo.public_send(sym, 'hello')
      assert_equal sym, @request.http_method
      assert_equal({}, @request.query)
      assert_equal 'hello', @request.path
      assert_equal '', @request.body

      Scalingo.public_send(sym, 'hello', {hello: :world})
      assert_equal sym, @request.http_method
      assert_equal({}, @request.query)
      assert_equal 'hello', @request.path
      assert_equal({hello: :world}, @request.body)
    end
  end
end

