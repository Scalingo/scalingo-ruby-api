RSpec.shared_context "with the default endpoint context" do
  subject do
    response # need to be defined in the including context
    WebMock # returning this lets us use the one-liner `have_requested` syntax
  end

  let(:bearer_token) { "Bearer token" }

  let(:arguments) do
    args = {}
    args[:connected] = connected if defined?(connected)
    args[:basic] = basic if defined?(basic)
    args[:body] = body if defined?(body)
    args.merge!(params) if defined?(params)
    args.compact!

    args
  end

  let(:scalingo_client) do
    scalingo = Scalingo::Client.new
    scalingo.authenticate_with(bearer_token: bearer_token) if bearer_token
    scalingo
  end

  let(:api_path) { URI.parse("http://localhost") }

  let(:api_client) { described_class.module_parent.new(api_path.to_s, scalingo: scalingo_client, region: :some_region) }
  let(:instance) { described_class.new(api_client) }
end

RSpec.shared_examples "requires authentication" do
  context "when the client is not authenticated" do
    let(:bearer_token) { nil }

    it "raises an exception" do
      expect { subject }.to raise_error(Scalingo::Error::Unauthenticated)
    end
  end
end

RSpec.shared_examples "requires some params" do |*keys|
  keys.each do |key|
    context "when #{key} is missing" do
      before { params.delete(key) }

      it "raises an exception" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
