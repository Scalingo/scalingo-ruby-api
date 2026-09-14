require "scalingo/api/endpoint"

module Scalingo
  class Regional::AppFirewallRules < API::Endpoint
    get :list, "apps/{app_id}/firewall_rules"
    get :find, "apps/{app_id}/firewall_rules/{id}"
    post :create, "apps/{app_id}/firewall_rules", root_key: :firewall_rule
    delete :delete, "apps/{app_id}/firewall_rules/{id}"
  end
end
