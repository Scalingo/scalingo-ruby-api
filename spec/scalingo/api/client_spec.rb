require "spec_helper"

RSpec.describe Scalingo::API::Client do
  let(:url) { "http://localhost" }

  subject { described_class.new(url, scalingo: scalingo) }

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
      expect(instance.instance_variable_get(:@handler)).to eq(nil)
      instance.handler

      # Memoized...
      expect(instance.instance_variable_get(:@handler)).not_to eq(nil)

      # More calls won't try to perform more instanciations
      instance.handler
      instance.handler
    end
  end

  describe "headers" do
    before do
      expect(scalingo.config).to receive(:user_agent).and_return(user_agent).once
    end

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

  describe "unauthenticated_connection" do
    it "returns a memoized object" do
      expect(Faraday).to receive(:new).with(subject.connection_options).and_return("faraday").once

      expect(subject.unauthenticated_connection).to eq "faraday"

      subject.unauthenticated_connection
      subject.unauthenticated_connection
    end

    it "has no authentication header set" do
      expect(subject.unauthenticated_connection.headers.key?("Authorization")).not_to be true
    end
  end

  describe "authenticated_connection" do
    context "without bearer token" do
      let(:scalingo) { scalingo_guest }

      it "raises if configured to" do
        expect(scalingo.config).to receive(:raise_on_missing_authentication).and_return(true).once

        expect {
          subject.authenticated_connection
        }.to raise_error(Scalingo::Error::Unauthenticated)
      end

      it "returns an unauthenticated connection if configured to not raise" do
        expect(scalingo.config).to receive(:raise_on_missing_authentication).and_return(false).once

        expect(subject).to receive(:unauthenticated_connection).and_return(:object).once
        expect(subject.authenticated_connection).to eq(:object)
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

  describe "database_connection" do
    let(:database_id) { "db-id-1234" }

    context "without bearer token" do
      let(:scalingo) { scalingo_guest }

      it "raises" do
        expect {
          subject.database_connection(database_id)
        }.to raise_error(Scalingo::Error::Unauthenticated)
      end
    end

    context "with bearer token" do
      before { stub_request(:any, "localhost") }

      it "has an authentication header set with a bearer scheme" do
        scalingo.authenticate_database_with_bearer_token(
          database_id,
          "1234",
          expires_at: Time.now + 1.hour,
          raise_on_expired_token: false
        )

        request_headers = subject.database_connection(database_id).get("/").env.request_headers
        expected = "Bearer #{subject.token_holder.database_tokens[database_id].value}"

        expect(request_headers["Authorization"]).to eq(expected)
      end
    end

    context "with wrong bearer token" do
      it "raises" do
        database_id_2 = "db-id-5678"
        scalingo.authenticate_database_with_bearer_token(
          database_id_2,
          "1234",
          expires_at: Time.now + 1.hour,
          raise_on_expired_token: false
        )
        expect {
          subject.database_connection(database_id)
        }.to raise_error(Scalingo::Error::Unauthenticated)
      end
    end
  end

  describe "connection" do
    context "logged" do
      context "no fallback to guest" do
        it "calls and return the authenticated_connection" do
          expect(subject).to receive(:authenticated_connection).and_return(:conn)
          expect(subject.connection).to eq(:conn)
        end
      end

      context "with fallback to guest" do
        it "calls and return the authenticated_connection" do
          expect(subject).to receive(:authenticated_connection).and_return(:conn)
          expect(subject.connection(fallback_to_guest: true)).to eq(:conn)
        end
      end
    end

    context "not logged" do
      let(:scalingo) { scalingo_guest }

      context "no fallback to guest" do
        it "raises when set to raise" do
          expect(scalingo.config).to receive(:raise_on_missing_authentication).and_return(true).once

          expect { subject.connection }.to raise_error(Scalingo::Error::Unauthenticated)
        end

        it "calls and return the unauthenticated_connection when set not to raise" do
          expect(scalingo.config).to receive(:raise_on_missing_authentication).and_return(false).once
          expect(subject).to receive(:unauthenticated_connection).and_return(:conn)
          expect(subject.connection(fallback_to_guest: true)).to eq(:conn)
        end
      end

      context "with fallback to guest" do
        it "calls and return the unauthenticated_connection" do
          expect(subject).to receive(:unauthenticated_connection).and_return(:conn)
          expect(subject.connection(fallback_to_guest: true)).to eq(:conn)
        end
      end
    end
  end
end
