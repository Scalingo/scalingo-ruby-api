require "spec_helper"

RSpec.describe Scalingo::Regional::Metrics, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "types" do
    subject(:response) { instance.types(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/features/metrics")) }
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    let(:params) { {app_id: app_id, metric: "some-metric"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :metric

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/stats/some-metric")) }

    context "with container type" do
      let(:params) { {app_id: app_id, metric: "some-metric", container_type: "web"} }

      it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/stats/some-metric/web")) }
    end

    context "with container type and index" do
      let(:params) { {app_id: app_id, metric: "some-metric", container_type: "web", container_index: "7"} }

      it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/stats/some-metric/web/7")) }
    end
  end
end
