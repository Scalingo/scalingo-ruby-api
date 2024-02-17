require "spec_helper"

RSpec.describe Scalingo::Regional::Events, type: :endpoint do
  describe "types" do
    subject(:response) { instance.types(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/event_types")) }
  end

  describe "categories" do
    subject(:response) { instance.categories(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/event_categories")) }
  end

  describe "all" do
    subject(:response) { instance.all(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/events")) }

    context "with query string" do
      let(:params) { {query: {page: 2}} }

      it { is_expected.to have_requested(:get, api_path.merge("/events?page=2")) }
    end
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    let(:app_id) { "my-app-id" }
    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/events")) }

    context "with query string" do
      let(:params) { {app_id: app_id, query: {page: 2}} }

      it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/events?page=2")) }
    end
  end
end
