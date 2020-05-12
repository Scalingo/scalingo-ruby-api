module Scalingo
  VALID_ACCESS_TOKEN = "lala"
  VALID_BEARER_TOKEN = "the-bearer-token"

  module StubHelpers
    ENDPOINTS = {
      auth: "https://auth.scalingo.com/v1"
    }

    def project_root
      File.expand_path("../..", File.dirname(__FILE__))
    end

    def samples_root
      File.join(project_root, "samples")
    end

    def register_stubs!(pattern = "**/*")
      api, folder = described_class.to_s.underscore.split("/").last(2)
      endpoint = ENDPOINTS.fetch(api.to_sym)

      path = [samples_root, api, folder].compact.join("/")

      Dir["#{path}/#{pattern}.json"].each do |path|
        stub_data = JSON.parse(File.read(path), symbolize_names: true)

        url = File.join(endpoint, stub_data[:path])
        method = (stub_data[:method] || :get).to_sym

        request_options = {
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent" => "Scalingo Ruby Client v3.0.0-pre",
          },
        }

        if stub_data[:request].present?
          req = stub_data[:request]

          if req[:headers].present?
            request_options[:headers].update(req[:headers])
          end

          if req[:json_body].present?
            request_options[:headers]["Content-Type"] = "application/json"
            request_options[:body] = JSON.generate(req[:json_body])
          end
        end

        response_options = {
          status: stub_data.dig(:response, :status) || 200,
          headers: {},
        }

        if stub_data.dig(:response, :json_body).present?
          response_options[:headers]["Content-Type"] = "application/json"
          response_options[:body] = JSON.pretty_generate( stub_data[:response][:json_body])
        end


        stub_request(method, url).with(request_options).to_return(response_options)
      end
    end
  end
end
