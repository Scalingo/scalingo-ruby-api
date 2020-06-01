RSpec.shared_examples "a successful response" do |code = 200|
  let(:expected_code) { code }

  it "should be succesful" do
    expect(response).to be_successful
    expect(response.status).to eq code
  end
end

RSpec.shared_examples "a not found response" do
  it "cannot be found" do
    expect(response).not_to be_successful
    expect(response.status).to eq 404
  end
end

RSpec.shared_examples "a client error" do
  it "is a generic client error" do
    expect(response).not_to be_successful
    expect(response.status).to eq 400
  end
end

RSpec.shared_examples "an unprocessable request" do
  it "cannot be found" do
    expect(response).not_to be_successful
    expect(response.status).to eq 422
  end
end

RSpec.shared_examples "a collection response" do |code = 200|
  it_behaves_like "a successful response", code

  it "should be an array" do
    expect(response.data).to be_a_kind_of(Array)
  end

  let(:expected_count) { 1 } unless method_defined?(:expected_count)

  it "should have the number of expected elements" do
    expect(response.data.size).to eq(expected_count)
  end
end

RSpec.shared_examples "a paginated collection" do |code = 200|
  it "should be paginated" do
    expect(response).to be_paginated
  end
end

RSpec.shared_examples "a non-paginated collection" do |code = 200|
  it "should not be paginated" do
    expect(response).not_to be_paginated
  end
end

RSpec.shared_examples "a method with a configurable request" do
  let(:valid_arguments) { nil } unless method_defined?(:valid_arguments)
  let(:custom_headers) { { "X-Custom-Header" => "custom"} } unless method_defined?(:custom_headers)

  it "can configure the request via a block" do
    expect { |block|
      endpoint.send(*[method_name, valid_arguments].compact, &block)
    }.to yield_with_args(Faraday::Request)
  end

  it "can configure headers via the last argument" do
    expect { |b| endpoint.send(*[method_name, valid_arguments].compact, &b) }.to yield_control

    endpoint.send(*[method_name, valid_arguments, custom_headers].compact) do |conn|
      expect(conn.headers["X-Custom-Header"]).to eq "custom"
    end
  end
end
