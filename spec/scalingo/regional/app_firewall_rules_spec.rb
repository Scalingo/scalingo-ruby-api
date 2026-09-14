require "spec_helper"

RSpec.describe Scalingo::Regional::AppFirewallRules, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/firewall_rules")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {cidr: "10.0.0.0/24", label: "Office"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it do
      response
      expect(WebMock).to have_requested(:post, api_path.merge("/apps/my-app-id/firewall_rules"))
        .with(body: {firewall_rule: body})
    end
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "firewall-rule-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/firewall_rules/firewall-rule-id")) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "firewall-rule-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/firewall_rules/firewall-rule-id")) }
  end
end
