require "spec_helper"
require "scalingo/faraday/extract_meta"

RSpec.shared_examples "no meta extraction" do
  it "does not extract meta from response" do
    expect(subject.meta).to eq(nil)
    expect(subject.meta?).to eq(false)
    expect(subject.pagination).to eq(nil)
    expect(subject.paginated?).to eq(false)
    expect(subject.cursor_pagination).to eq(nil)
    expect(subject.cursor_paginated?).to eq(false)
  end
end

RSpec.describe Scalingo::ExtractMeta do
  let(:headers) { {"Content-Type" => content_type}.compact }
  let(:content_type) { "application/json" }
  let(:body) { nil }

  let(:client) do
    Faraday.new do |b|
      b.response :extract_meta
      b.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
      b.adapter :test do |stub|
        stub.get("/") { [nil, headers, body] }
      end
    end
  end

  subject { client.get("/") }

  context "with a non-json response" do
    let(:content_type) { "text/html" }
    let(:body) { "string".to_json }

    include_examples "no meta extraction"
  end

  context "without a body" do
    include_examples "no meta extraction"
  end

  context "with a non indexable body" do
    let(:body) { "string".to_json }

    include_examples "no meta extraction"
  end

  context "with a non hash indexable body" do
    let(:body) { [1, 2, 3].to_json }

    include_examples "no meta extraction"
  end

  context "with a hash" do
    context "without a meta key" do
      let(:body) { {a: 1, b: 2}.to_json }

      include_examples "no meta extraction"
    end

    context "with a generic meta key" do
      let(:body) { {meta: {a: 1}}.to_json }

      it "extracts the meta" do
        expect(subject.meta).to eq({a: 1})
        expect(subject.meta?).to eq(true)
        expect(subject.pagination).to eq(nil)
        expect(subject.paginated?).to eq(false)
        expect(subject.cursor_pagination).to eq(nil)
        expect(subject.cursor_paginated?).to eq(false)
      end
    end

    context "with a pagination meta key" do
      let(:body) { {meta: {pagination: {page: 1}}}.to_json }

      it "extracts the meta" do
        expect(subject.meta).to eq({pagination: {page: 1}})
        expect(subject.meta?).to eq(true)
        expect(subject.pagination).to eq({page: 1})
        expect(subject.paginated?).to eq(true)
        expect(subject.cursor_pagination).to eq(nil)
        expect(subject.cursor_paginated?).to eq(false)
      end
    end

    context "with a cursor pagination" do
      let(:body) { {next_cursor: 1, has_more: true}.to_json }

      it "extracts the meta" do
        expect(subject.meta).to eq({cursor_pagination: {next_cursor: 1, has_more: true}})
        expect(subject.meta?).to eq(true)
        expect(subject.pagination).to eq(nil)
        expect(subject.paginated?).to eq(false)
        expect(subject.cursor_pagination).to eq({next_cursor: 1, has_more: true})
        expect(subject.cursor_paginated?).to eq(true)
      end
    end
  end
end
