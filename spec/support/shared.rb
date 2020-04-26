RSpec.shared_examples "a successful response" do |code = 200|
  let(:expected_code) { code }

  it "should be succesful" do
    expect(response).to be_successful
  end
end

RSpec.shared_examples "a collection response" do |code = 200|
  it_behaves_like "a successful response", code

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
