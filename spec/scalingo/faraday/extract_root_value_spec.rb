require "spec_helper"
require "scalingo/faraday/extract_root_value"

RSpec.describe Scalingo::ExtractRootValue do
  subject { client.get("/") }

  let(:status) { 200 }
  let(:body) { {a: 1} }

  let(:client) do
    Faraday.new do |b|
      b.response :extract_root_value
      b.adapter :test do |stub|
        stub.get("/") { [status, {}, body] }
      end
    end
  end

  context "with a non-successful response" do
    let(:status) { 300 }

    it "does not change the response body" do
      expect(subject.body).to eq({a: 1})
    end
  end

  context "with a non-hash response" do
    let(:body) { [{a: 1}] }

    it "does not change the response body" do
      expect(subject.body).to eq([{a: 1}])
    end
  end

  context "with a multi keys hash" do
    let(:body) { {a: 1, b: 2} }

    it "does not change the response body" do
      expect(subject.body).to eq({a: 1, b: 2})
    end
  end

  context "with a single key hash" do
    it "extracts the response body" do
      expect(subject.body).to eq(1)
    end
  end
end
