require "spec_helper"

RSpec.describe Scalingo::API::Response do
  let(:client) { regional }
  let(:status) { 200 }
  let(:headers) { {} }
  let(:data) { "" }
  let(:full_body) { "" }
  let(:meta_object) { nil }

  subject {
    described_class.new(
      client: client,
      status: status,
      headers: headers,
      data: data,
      full_body: full_body,
      meta: meta_object,
    )
  }

  describe "self.unpack" do
    let(:body) { "" }
    let(:success) { true }

    let(:response) {
      OpenStruct.new(
        body: body,
        status: status,
        headers: headers,
        success?: success,
      )
    }

    it "passes the client supplied" do
      object = described_class.unpack(:some_client, response)

      expect(object.client).to eq :some_client
    end

    it "passes the response status" do
      object = described_class.unpack(:client, response)

      expect(object.status).to eq status
    end

    it "passes the response headers" do
      object = described_class.unpack(:client, response)

      expect(object.headers).to eq headers
    end

    context "with an empty body" do
      let(:body) { "" }

      it "without key" do
        object = described_class.unpack(client, response)

        expect(object.data).to eq ""
        expect(object.full_body).to eq ""
        expect(object.meta).to eq nil
      end

      it "ignores key if supplied" do
        object = described_class.unpack(client, response, key: :key)

        expect(object.data).to eq ""
        expect(object.full_body).to eq ""
        expect(object.meta).to eq nil
      end
    end

    context "with a nil body" do
      let(:body) { nil }

      it "without key" do
        object = described_class.unpack(client, response)

        expect(object.data).to eq nil
        expect(object.full_body).to eq nil
        expect(object.meta).to eq nil
      end

      it "ignores key if supplied" do
        object = described_class.unpack(client, response, key: :key)

        expect(object.data).to eq nil
        expect(object.full_body).to eq nil
        expect(object.meta).to eq nil
      end
    end

    context "with a string body" do
      let(:body) { "this is a string body, probably due to an error" }

      it "without key" do
        object = described_class.unpack(client, response)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end

      it "ignores key if supplied" do
        object = described_class.unpack(client, response, key: :key)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end
    end

    context "with an json (array) body" do
      let(:body) {
        [{key: :value}]
      }

      it "without key" do
        object = described_class.unpack(client, response)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end

      it "ignores key if supplied" do
        object = described_class.unpack(client, response, key: :root)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end
    end

    context "with a json (hash) body" do
      let(:body) {
        {root: {key: :value}}
      }

      it "without key" do
        object = described_class.unpack(client, response)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end

      it "with valid key" do
        object = described_class.unpack(client, response, key: :root)

        expect(object.data).to eq({key: :value})
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end

      it "with invalid key" do
        object = described_class.unpack(client, response, key: :other)

        expect(object.data).to eq nil
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end

      context "with meta" do
        let(:body) {
          {root: {key: :value}, meta: {meta1: :value}}
        }

        it "extracts the meta object" do
          object = described_class.unpack(client, response)

          expect(object.meta).to eq({meta1: :value})
        end
      end
    end

    context "with an error response" do
      let(:success) { false }
      let(:body) { {root: {key: :value}} }

      it "does not dig in the response hash, even with a valid key" do
        object = described_class.unpack(client, response, key: :root)

        expect(object.data).to eq body
        expect(object.full_body).to eq body
        expect(object.meta).to eq nil
      end
    end
  end

  describe "successful?" do
    context "is true when 2XX" do
      let(:status) { 200 }
      it { expect(subject.successful?).to be true }
    end

    context "is false when 3XX" do
      let(:status) { 300 }
      it { expect(subject.successful?).to be false }
    end

    context "is false when 4XX" do
      let(:status) { 400 }
      it { expect(subject.successful?).to be false }
    end

    context "is false when 5XX" do
      let(:status) { 500 }
      it { expect(subject.successful?).to be false }
    end
  end

  describe "paginated?" do
    context "with pagination metadata" do
      let(:meta_object) {
        {pagination: {page: 1}}
      }

      it { expect(subject.paginated?).to be true }
    end

    context "without pagination metadata" do
      let(:meta_object) {
        {messages: []}
      }

      it { expect(subject.paginated?).to be false }
    end
  end

  describe "operation" do
    context "with an operation url" do
      before do
        load_meta!(api: :regional, folder: :operations)
        register_stubs!("find-200", api: :regional, folder: :operations)
      end

      let(:url) {
        path = "/apps/#{meta[:app_id]}/operations/#{meta[:id]}"
        File.join(Scalingo::ENDPOINTS[:regional], path)
      }

      let(:headers) {
        {location: url}
      }

      it { expect(subject.operation?).to be true }
      it { expect(subject.operation_url).to eq url }

      it "can request the operation" do
        response = subject.operation

        expect(response).to be_successful
        expect(response.data[:id]).to be_present
        expect(response.data[:status]).to be_present
        expect(response.data[:type]).to be_present
      end

      it "delegates the operation to the given client" do
        mock = double

        expect(subject.client).to receive(:operations).and_return(mock)
        expect(mock).to receive(:get).with(url).and_return(:response)

        expect(subject.operation).to eq :response
      end

      context "when the client doesn't know about operations" do
        let(:client) { auth }

        it "fails silently" do
          expect(subject.operation).to eq nil
        end
      end
    end

    context "without an operation url" do
      let(:meta_object) { {} }

      it { expect(subject.operation?).to be false }
      it { expect(subject.operation_url).to eq nil }
      it { expect(subject.operation).to eq nil }
    end
  end
end
