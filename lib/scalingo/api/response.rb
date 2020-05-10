module Scalingo
  module API
    class Response
      def self.transform_object(object, resource_class: nil)
        resource_class&.new(object) || object
      end

      def self.transform_body(body, resource_class: nil)
        case body
        when Hash
          transform_object(body, resource_class: resource_class)
        when Array
          body.map { |item| transform_object(item, resource_class: resource_class) }
        else
          body
        end
      end

      def self.transform_meta(body)
        if body.present? && body.key?(:meta)
          body[:meta]
        end
      end

      def self.unpack(response, key: nil, resource_class: nil)
        data = key ? response.body[key] : response.body
        parsed = transform_body(data, resource_class: resource_class)
        meta = transform_meta(response.body)

        new(
          status: response.status,
          headers: response.headers,
          data: parsed,
          meta: meta,
          full_body: response.body
        )
      end

      attr_reader :status, :headers, :data, :full_body, :meta

      def initialize(status:, headers:, data:, full_body:, meta: nil)
        @status = status
        @headers = headers
        @data = data
        @full_body = full_body
        @meta = meta
      end

      def successful?
        status >= 200 && status < 300
      end

      def paginated?
        meta&.dig(:pagination).present?
      end

      def operation
        headers[:location]
      end

      def operation?
        operation.present
      end
    end
  end
end
