require 'test_helper'

class EndpointResourceTest < BaseTestCase
  test 'initialize' do
    resource = Scalingo::Endpoint::Resource.new(
      'api', 'prefix', {}, hello: :world, world: :hello,
    )
    assert_equal 'api', resource.api
    assert_equal 'prefix', resource.prefix

    assert resource.respond_to?(:hello)
    assert_equal :world, resource.hello

    assert resource.respond_to?(:world)
    assert_equal :hello, resource.world
  end
end

