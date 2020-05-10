require "scalingo/api/base_client"

module Scalingo
  class Regional < API::BaseClient
    require "scalingo/regional/addons"
    require "scalingo/regional/apps"
    require "scalingo/regional/collaborators"
    require "scalingo/regional/containers"
    require "scalingo/regional/deployments"
    require "scalingo/regional/domains"
    require "scalingo/regional/environment"
    require "scalingo/regional/events"
    require "scalingo/regional/logs"
    require "scalingo/regional/metrics"
    require "scalingo/regional/notifiers"

    register_handlers!(
      addons: Addons,
      apps: Apps,
      collaborators: Collaborators,
      containers: Containers,
      deployments: Deployments,
      domains: Domains,
      environment: Environment,
      events: Events,
      logs: Logs,
      metrics: Metrics,
      notifiers: Notifiers,
    )
  end
end
