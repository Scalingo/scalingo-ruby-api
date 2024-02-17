require "spec_helper"

RSpec.describe Scalingo::Regional::Logs, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "archives" do
    subject(:response) { instance.archives(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/logs_archives")) }
  end

  describe "get" do
    subject(:response) { instance.get("http://localhost/any-url", **arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, "http://localhost/any-url") }

    context "with limit" do
      let(:params) { {n: 3} }

      it { is_expected.to have_requested(:get, "http://localhost/any-url?n=3") }
    end

    context "with other params" do
      let(:params) { {z: 7} }

      it { is_expected.to have_requested(:get, "http://localhost/any-url") }
    end
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    let(:params) { {app_id: app_id} }

    context "with a successful call for the logs url" do
      before do
        stub_request(:get, api_path.merge("/apps/my-app-id/logs")).to_return(
          status: 200,
          body: "http://localhost/signed-url"
        )
      end

      it { is_expected.to have_requested(:get, "http://localhost/signed-url") }
    end

    context "with a failed call for the logs url" do
      before do
        stub_request(:get, api_path.merge("/apps/my-app-id/logs")).to_return(
          status: 404,
          body: "http://localhost/signed-url"
        )
      end

      it "returns the first response" do
        expect(subject).not_to have_requested(:get, "http://localhost/signed-url")
        expect(subject.status).to eq 404
        expect(subject.env.url).to eq api_path.merge("/apps/my-app-id/logs")
      end
    end
  end
end
