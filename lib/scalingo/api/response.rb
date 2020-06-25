module Scalingo
  module API
    class Response
      def self.timeout(client)
        new(
          client: client,
          status: nil,
          headers: nil,
          data: nil,
          meta: nil,
          full_body: nil,
        )
      end

      def self.unpack(client, key: nil, &block)
        begin
          response = block.call
        rescue Faraday::ConnectionFailed
          return timeout(client)
        end

        body = response.body
        has_hash_body = body.present? && body.respond_to?(:key)

        data = body
        meta = nil

        if has_hash_body
          data = body[key] if response.success? && key.present?
          meta = body[:meta]
        end

        new(
          client: client,
          status: response.status,
          headers: response.headers,
          data: data,
          meta: meta,
          full_body: body,
        )
      end

      attr_reader :client, :status, :headers, :data, :full_body, :meta

      def initialize(client:, status:, headers:, data:, full_body:, meta: nil)
        @client = client
        @status = status
        @headers = headers
        @data = data
        @full_body = full_body
        @meta = meta
      end

      def inspect
        %(<#{self.class}:0x#{object_id.to_s(16)} status:#{@status} data:#{@data} meta:#{@meta}>)
      end

      def successful?
        status.present? && status >= 200 && status < 300
      end

      def timeout?
        status.nil?
      end

      def paginated?
        meta&.dig(:pagination).present?
      end

      def operation
        if operation? && client.respond_to?(:operations)
          client.operations.get(operation_url)
        end
      end

      def operation_url
        headers[:location]
      end

      def operation?
        operation_url.present?
      end
    end
  end
end
