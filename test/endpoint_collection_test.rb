require 'test_helper'

class Scalingo::Endpoint::TestEndpoint
end

class EndpointCollectionTest < BaseTestCase
  class ApiMock
    def get(path, options = {})
      {
        path => collection,
      }
    end

    def collection
      [
        {
          id: 1,
          name: 'test1',
        },
        {
          id: 2,
          name: 'test2',
        },
        {
          id: 4,
          name: 'test4',
        },
        {
          id: 5,
          name: 'test5',
        },
      ]
    end
  end

  class CollectionTests < Scalingo::Endpoint::Collection
  end

  setup do
    @api = ApiMock.new
    @collection = CollectionTests.new(@api)
  end

  test 'all' do
    result = @collection.all
    assert_equal Array, result.class
    assert @collection.class < Enumerable
    assert_equal @api.collection.count, @collection.count
  end

  test 'find' do
    result = @collection.find(2)
    assert_equal 2, result.id
    assert_equal 'test2', result.name
  end

  test 'collection_name' do
    assert_equal 'collection_tests', @collection.collection_name
  end

  test 'resource_class' do
    assert_equal Scalingo::Endpoint::Resource, @collection.resource_class
  end

  class TestEndpoints < Scalingo::Endpoint::Collection
  end

  test 'resource_class if singular class exists' do
    @collection = TestEndpoints.new(@api, @prefix)
    assert_equal Scalingo::Endpoint::TestEndpoint, @collection.resource_class
  end

  test 'find_by' do
    assert_equal 'id', @collection.find_by
  end
end

