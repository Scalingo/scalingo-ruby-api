require "addressable/template"
require "forwardable"

module Scalingo
  module API
    class Endpoint
      extend Forwardable
      attr_reader :client

      # Add a handler for a given endpoint
      %i[get post put patch delete].each do |method|
        # @example
        # class Example < API::Endpoint
        #   get :all, "some-endpoint/{id}/subthings{?query*}", optional: [:query]
        #   post :create, "some-endpoint", root_key: :subthing
        # end
        define_singleton_method(method) do |name, path, **default_attrs, &default_block|
          # @example
          # endpoint = Example.new
          # endpoint.all(id: "1", query: {page: 1})
          # endpoint.create(name: "thing")
          define_method(name) do |**runtime_attrs, &runtime_block|
            params = {**default_attrs, **runtime_attrs}

            request(method, path, **params) do |req|
              default_block&.call(req, params)
              runtime_block&.call(req, params)
            end
          end
        end

        # Those methods are not meant to be used outside of a class definition
        private_class_method method
      end

      def initialize(client)
        @client = client
      end

      def_delegator :client, :connection
      def_delegator :client, :database_connection

      # Perform a request to the API.
      # path can be an URI template; and faraday expect valid URIs - the parser raises when templates aren't fully expanded.
      # therefore, we have to take care of the expansion before passing the path to faraday.
      # note: This method is not unit-tested directly, but integrations tests are covering it extensively.
      # @see https://github.com/sporkmonger/addressable?tab=readme-ov-file#uri-templates
      # @see https://www.rfc-editor.org/rfc/rfc6570.txt
      # @see https://github.com/lostisland/faraday/issues/1487
      def request(method, path, body: nil, root_key: nil, connected: true, basic: nil, dry_run: false, params_as_body: false, **params, &block)
        template = Addressable::Template.new(path)

        # If the template has keys, we need to expand it with the params
        if template.keys.present?
          # We assume every variable in the template is required
          expected_keys = Set.new(template.keys.map(&:to_sym))
          # ... but we can opt out by specifying :optional when performing the request or in the endpoint definition
          expected_keys -= params[:optional] if params[:optional].present?

          # if any required key is missing, raise an error with the missing keys,
          # as if it was a regular keyword argument that was not supplied
          if expected_keys.present?
            received_keys = Set.new(params.keys.map(&:to_sym))

            unless received_keys.superset?(expected_keys)
              missings = (expected_keys - received_keys).map { |item| sprintf("%p", item) }.join(" ")
              raise ArgumentError, "missing keyword: #{missings}"
            end
          end

          # Now, we can expand the template with the supplied params
          actual_path = template.expand(params).to_s
        else
          # Otherwise, it's not a template but a string to be used as it is
          actual_path = path
        end

        # we nest the given body under the root_key if it's present
        request_body = body
        request_body = {root_key => body} if request_body && root_key

        # We can use the client in either connected or unconnected mode
        conn = connected ? client.authenticated_connection : client.unauthenticated_connection

        # We can specify basic auth credentials if needed
        conn.request :authorization, :basic, basic[:user], basic[:password] if basic.present?

        # Finally, perform the request.
        # Faraday sends params as query string for GET/HEAD/DELETE requests and as request body for the others;
        # in some rare cases (variables bulk-delete) we need to send them as actual body.
        if Faraday::METHODS_WITH_QUERY.include?(method.to_s) && params_as_body
          conn.public_send(method, actual_path) do |req|
            req.body = request_body
            block&.call(req) || req
          end
        else
          conn.public_send(method, actual_path, request_body, &block)
        end
      end

      # :nocov:
      def inspect
        str = %(<#{self.class}:0x#{object_id.to_s(16)} base_url:"#{@client.url}" endpoints:)

        str << self.class.instance_methods(false).to_s
        str << ">"
        str
      end
      # :nocov:
    end
  end
end
