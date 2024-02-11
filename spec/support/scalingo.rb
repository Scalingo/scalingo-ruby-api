module Scalingo
  VALID_ACCESS_TOKEN = "lala"
  VALID_BEARER_TOKEN = "the-bearer-token"

  ENDPOINTS = {
    auth: "https://auth.scalingo.test",
    billing: "https://billing.scalingo.test",
    regional: "https://regional.scalingo.test",
    regional_database: "https://regional-database.scalingo.test"
  }

  class SpecClient < CoreClient
    def auth
      @auth ||= Auth.new(ENDPOINTS[:auth], scalingo: self)
    end

    def billing
      @billing ||= Billing.new(ENDPOINTS[:billing], scalingo: self)
    end

    def regional
      @regional ||= Regional.new(ENDPOINTS[:regional], scalingo: self)
    end
  end

  module StubHelpers
    def project_root
      File.expand_path("../..", File.dirname(__FILE__))
    end

    def samples_root
      File.join(project_root, "samples")
    end

    def load_meta!(api: nil, folder: nil)
      guessed_api, guessed_folder = described_class.to_s.underscore.split("/").last(2)
      api ||= guessed_api
      folder ||= guessed_folder

      path = [samples_root, api, folder, "_meta.json"].compact.join("/")

      if File.exist?(path)
        @meta = JSON.parse(File.read(path), symbolize_names: true)
      end
    end

    def register_stubs!(pattern = "**/*", api: nil, folder: nil)
      guessed_api, guessed_folder = described_class.to_s.underscore.split("/").last(2)
      api ||= guessed_api
      folder ||= guessed_folder

      endpoint = ENDPOINTS.fetch(api.to_sym)

      path = [samples_root, api, folder].compact.join("/")

      Dir["#{path}/#{pattern}.json"].each do |path|
        stub_data = JSON.parse(File.read(path), symbolize_names: true)

        url = stub_data[:url] || File.join(endpoint, stub_data[:path])
        method = (stub_data[:method] || :get).to_sym

        request_options = {}

        if stub_data[:request].present?
          req = stub_data[:request]

          if req[:headers].present?
            request_options[:headers] ||= {}
            request_options[:headers].update(req[:headers])
          end

          if req[:json_body].present?
            request_options[:headers] ||= {}
            request_options[:headers]["Content-Type"] = "application/json"
            request_options[:body] = JSON.generate(req[:json_body])
          end
        end

        response_options = {
          status: stub_data.dig(:response, :status) || 200,
          headers: {}
        }

        if stub_data.dig(:response, :json_body).present?
          response_options[:headers]["Content-Type"] = "application/json"
          response_options[:body] = JSON.pretty_generate(stub_data[:response][:json_body])
        end

        stubbing = stub_request(method, url)
        stubbing = stubbing.with(request_options) if request_options.any?
        stubbing.to_return(response_options)
      end
    end
  end

  module DescribedMethod
    def describe_method(method_name, &block)
      unless described_class.instance_methods.include?(method_name.to_sym)
        raise NameError, "No method named `#{method_name}` for class #{described_class}"
      end

      # Helper method to quickly define a context for a method with default let values
      context(method_name) do
        let(:method_name) { method_name }
        let(:basic) { nil }
        let(:params) { {} }
        let(:body) { nil }
        let(:arguments) { nil }

        let(:response) {
          args = [method_name]

          # A few methods use positional arguments
          if arguments.is_a?(Array)
            args += arguments
          elsif arguments
            args << arguments
          end

          args.compact!

          subject.public_send(*args, body: body, basic: basic, **params)
        }

        instance_exec(&block)
      end
    end
  end

  module Common
    extend RSpec::SharedContext
    let(:scalingo_guest) { Scalingo::SpecClient.new }
    let(:scalingo) { Scalingo::SpecClient.new.tap { |c| c.authenticate_with(bearer_token: Scalingo::VALID_BEARER_TOKEN) } }
    let(:auth) { Scalingo::Auth.new(ENDPOINTS[:auth], scalingo: scalingo) }
    let(:auth_guest) { Scalingo::Auth.new(ENDPOINTS[:auth], scalingo: scalingo_guest) }
    let(:billing) { Scalingo::Billing.new(ENDPOINTS[:billing], scalingo: scalingo) }
    let(:billing_guest) { Scalingo::Billing.new(ENDPOINTS[:billing], scalingo: scalingo_guest) }
    let(:regional) { Scalingo::Regional.new(ENDPOINTS[:regional], scalingo: scalingo) }
    let(:regional_guest) { Scalingo::Regional.new(ENDPOINTS[:regional], scalingo: scalingo_guest) }
    let(:regionaldatabase) { Scalingo::RegionalDatabase.new(ENDPOINTS[:regional_database], scalingo: scalingo) }
    let(:meta) { @meta }

    let(:endpoint) do
      if described_class < Scalingo::API::Endpoint
        api = described_class.to_s.split("::")[-2].downcase

        described_class.new(send(api))
      end
    end

    let(:guest_endpoint) do
      if described_class < Scalingo::API::Endpoint
        api = described_class.to_s.split("::")[-2].downcase

        described_class.new(send(:"#{api}_guest"))
      end
    end

    subject { endpoint }
  end
end
