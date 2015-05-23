require 'test_helper'

class EndpointBaseTest < BaseTestCase
  class ApiMock
    attr_accessor :method_called

    Scalingo::Request::REQUEST_METHODS.each do |method|
      define_method(method) do |path, options = {}|
        self.method_called = OpenStruct.new(http_method: method, path: path, options: options)
      end
    end
  end
  class EndpointBaseClass
    include Scalingo::Endpoint::Base
  end

  setup do
    @api = ApiMock.new
    @prefix = 'hello'
    @base = EndpointBaseClass.new(@api, @prefix)
  end

  Scalingo::Request::REQUEST_METHODS.each do |method|
    test "#{method}" do
      @base.send(method)
      assert_equal method, @api.method_called.http_method
      assert_equal "#{@prefix}/", @api.method_called.path
      assert_equal({}, @api.method_called.options)

      @base.send(method, 'test')
      assert_equal method, @api.method_called.http_method
      assert_equal "#{@prefix}/test", @api.method_called.path
      assert_equal({}, @api.method_called.options)

      @base.send(method, nil, {a: 1})
      assert_equal method, @api.method_called.http_method
      assert_equal "#{@prefix}/", @api.method_called.path
      assert_equal({a: 1}, @api.method_called.options)

      @base.send(method, 'test', {a: 1})
      assert_equal method, @api.method_called.http_method
      assert_equal "#{@prefix}/test", @api.method_called.path
      assert_equal({a: 1}, @api.method_called.options)
    end
  end

  test 'initialize without prefix' do
    @base = EndpointBaseClass.new(@api)
    assert_equal 'endpoint_base_classes', @base.prefix
  end
end

