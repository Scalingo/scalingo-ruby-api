RSpec.shared_examples "a successful response" do |code = 200|
  let(:expected_code) { code }
  let(:custom_headers) { {"X-Custom-Header" => "custom"} }

  it "is successful" do
    expect(response).to be_successful
    expect(response.status).to eq code
  end

  # Checking that the method accepts a block and passes the faraday object
  it "can configure the request via a block" do
    expect { |block|
      if arguments.is_a?(Array)
        subject.public_send(*[method_name, *arguments].compact, &block)
      else
        subject.public_send(*[method_name, arguments].compact, &block)
      end
    }.to yield_with_args(Faraday::Request)
  end

  # Leverages the block version to check that the headers can also be set with an argument
  it "can configure headers via the last argument" do
    checker = proc { |conn|
      expect(conn.headers["X-Custom-Header"]).to eq "custom"
    }

    if arguments.is_a?(Array)
      subject.public_send(*[method_name, *arguments, custom_headers].compact, &checker)
    else
      subject.public_send(*[method_name, arguments, custom_headers].compact, &checker)
    end
  end
end

RSpec.shared_examples "a client error" do
  it "is a generic client error" do
    expect(response).to be_client_error
    expect(response.status).to eq 400
  end
end

RSpec.shared_examples "a server error" do
  it "is a generic server error" do
    expect(response).to be_server_error
    expect(response.status).to eq 500
  end
end

RSpec.shared_examples "a not found response" do
  it "cannot be found" do
    expect(response).to be_client_error
    expect(response.status).to eq 404
  end
end

RSpec.shared_examples "an unprocessable request" do
  it "cannot be found" do
    expect(response).to be_client_error
    expect(response.status).to eq 422
  end
end

RSpec.shared_examples "a singular object response" do |code = 200|
  it_behaves_like "a successful response", code

  let(:expected_type) { Object } unless method_defined?(:expected_type)
  let(:expected_keys) { %i[id] } unless method_defined?(:expected_keys)

  it "is an object of the expected type (and if applicable, the expected keys)" do
    expect(response.data).to be_a_kind_of(expected_type)

    if response.data.respond_to?(:key?)
      expected_keys.each do |key|
        expect(response.data.key?(key)).to be true
      end
    end
  end
end

RSpec.shared_examples "an empty response" do |code = 204|
  it_behaves_like "a successful response", code

  it "is empty" do
    expect(response.data).to eq("")
  end
end

RSpec.shared_examples "a collection response" do |code = 200|
  it_behaves_like "a successful response", code

  let(:expected_count) { 1 } unless method_defined?(:expected_count)
  let(:expected_type) { Object } unless method_defined?(:expected_type)
  let(:expected_keys) { %i[id] } unless method_defined?(:expected_keys)

  it "is an array" do
    expect(response.data).to be_a_kind_of(Array)
  end

  it "contains the number of expected elements" do
    expect(response.data.size).to eq(expected_count)
  end

  it "items are of the expected type (and if applicable, the expected keys)" do
    response.data.each do |item|
      expect(item).to be_a_kind_of(expected_type)

      if item.respond_to?(:key?)
        expected_keys.each do |key|
          expect(item.key?(key)).to be true
        end
      end
    end
  end
end

RSpec.shared_examples "a paginated collection" do |code = 200|
  it "is paginated" do
    expect(response).to be_paginated
  end
end

RSpec.shared_examples "a cursor paginated collection" do |code = 200|
  it "is cursor paginated" do
    expect(response).to be_cursor_paginated
  end
end

RSpec.shared_examples "a non-paginated collection" do |code = 200|
  it "is not paginated" do
    expect(response).not_to be_paginated
  end
end
