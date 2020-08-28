require "scalingo/api/client"

module Scalingo
  class Regional < API::Client
    require "scalingo/regional/addons"
    require "scalingo/regional/apps"
    require "scalingo/regional/autoscalers"
    require "scalingo/regional/collaborators"
    require "scalingo/regional/containers"
    require "scalingo/regional/deployments"
    require "scalingo/regional/domains"
    require "scalingo/regional/environment"
    require "scalingo/regional/events"
    require "scalingo/regional/logs"
    require "scalingo/regional/metrics"
    require "scalingo/regional/notifiers"
    require "scalingo/regional/operations"
    require "scalingo/regional/scm_repo_links"

    register_handlers!(
      addons: Addons,
      apps: Apps,
      autoscalers: Autoscalers,
      collaborators: Collaborators,
      containers: Containers,
      deployments: Deployments,
      domains: Domains,
      environment: Environment,
      events: Events,
      logs: Logs,
      metrics: Metrics,
      notifiers: Notifiers,
      operations: Operations,
      scm_repo_links: ScmRepoLinks,
    )
  end
end
