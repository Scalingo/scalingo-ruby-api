require "spec_helper"

RSpec.describe Scalingo::API::Client do
  subject { described_class.new(url, scalingo: scalingo) }

  let(:url) { "http://localhost" }
  let(:bearer_token) { Scalingo.generate_test_jwt(duration: 1.hour) }
  let(:configuration) { {} }
  let(:scalingo) do
    scalingo_client = Scalingo::Client.new(configuration)
    scalingo_client.authenticate_with(bearer_token: bearer_token) if bearer_token
    scalingo_client
  end

  describe "initialize" do
    let(:config) { {default_region: :test} }

    describe "with only url" do
      subject { described_class.new(:url) }

      it "stores the url" do
        expect(subject.url).to eq(:url)
      end

      it "uses itself as token holder" do
        expect(subject.token_holder).to eq(subject)
      end

      it "configuration is the global one" do
        expect(Scalingo::Configuration).to receive(:new).with({}, Scalingo.config).and_return(:config).once

        expect(subject.config).to eq(:config)
      end
    end

    describe "with scalingo client supplied" do
      subject { described_class.new(:url, scalingo: scalingo) }

      it "uses the scalingo client as token holder" do
        expect(subject.token_holder).to eq(scalingo)
      end

      it "configuration is herited from the scalingo client" do
        expect(Scalingo::Configuration).to receive(:new).with({}, scalingo.config).once

        subject
      end
    end

    describe "with config supplied" do
      subject { described_class.new(:url, config: config) }

      it "configuration is herited from the global one" do
        expect(Scalingo::Configuration).to receive(:new).with(config, Scalingo.config).and_return(:config).once

        expect(subject.config).to eq(:config)
      end
    end

    describe "with both supplied" do
      subject { described_class.new(:url, scalingo: scalingo, config: config) }

      it "configuration is herited from the scalingo one" do
        expect(Scalingo::Configuration).to receive(:new).with(config, scalingo.config).once

        subject
      end
    end

    describe "region" do
      it "keeps track of the region if supplied" do
        instance = described_class.new(:url, region: "my-region")
        expect(instance.region).to eq("my-region")
      end
    end
  end

  describe "self.register_handler(s)!" do
    it "is called for each key/value pair" do
      expect(described_class).to receive(:register_handler!).with(:a, :b).once
      expect(described_class).to receive(:register_handler!).with(:c, :d).once

      described_class.register_handlers!(a: :b, c: :d)
    end

    it "defines a lazy-loaded memoized getter, returning an instance of the class supplied" do
      mock = double

      described_class.register_handler!(:handler, mock)
      instance = described_class.new(:url, scalingo: scalingo)

      # Only 1 instanciation should be done, no matter how many calls are done below
      expect(mock).to receive(:new).with(instance).and_return("1st").once

      # Not yet loaded...
      expect(instance.instance_variable_get(:@handler)).to be_nil
      instance.handler

      # Memoized...
      expect(instance.instance_variable_get(:@handler)).not_to be_nil

      # More calls won't try to perform more instanciations
      instance.handler
      instance.handler
    end
  end

  describe "headers" do
    let(:configuration) { {user_agent: user_agent} }
    let(:user_agent) { "user agent" }
    let(:extra_hash) { {"X-Other" => "other"} }
    let(:extra_block) {
      proc { {"X-Another" => "another"} }
    }

    it "only returns the user agent and accept if nothing else is configured" do
      expect(subject.headers).to eq("Accept" => "application/json", "User-Agent" => user_agent)
    end

    it "allows additional headers to be globally configured" do
      expect(scalingo.config).to receive(:additional_headers).and_return(extra_hash)

      expect(subject.headers).to eq("Accept" => "application/json", "User-Agent" => user_agent, "X-Other" => "other")
    end

    it "additional headers can be a block" do
      expect(scalingo.config).to receive(:additional_headers).and_return(extra_block)

      expect(subject.headers).to eq("Accept" => "application/json", "User-Agent" => user_agent, "X-Another" => "another")
    end
  end

  describe "connection_options" do
    it "returns the url and headers" do
      expect(subject).to receive(:url).and_return("url").once
      expect(subject).to receive(:headers).and_return("headers").once

      expect(subject.connection_options).to eq(url: "url", headers: "headers")
    end
  end

  describe "guest_connection" do
    it "returns a memoized object" do
      expect(Faraday).to receive(:new).with(subject.connection_options).and_return("faraday").once

      expect(subject.guest_connection).to eq "faraday"

      subject.guest_connection
      subject.guest_connection
    end

    it "has no authentication header set" do
      expect(subject.guest_connection.headers.key?("Authorization")).not_to be true
    end
  end

  describe "connection" do
    context "without bearer token" do
      let(:bearer_token) { nil }

      it "raises an exception" do
        expect { subject.connection }.to raise_error(Scalingo::Error::Unauthenticated)
      end
    end

    context "with bearer token" do
      before { stub_request(:any, "localhost") }

      it "has an authentication header set with a bearer scheme" do
        request_headers = subject.connection.get("/").env.request_headers
        expected = "Bearer #{subject.token_holder.token.value}"

        expect(request_headers["Authorization"]).to eq(expected)
      end
    end
  end
end
