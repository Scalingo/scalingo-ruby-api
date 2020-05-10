require "scalingo/api/base_client"

module Scalingo
  class Regional < API::BaseClient
    require "scalingo/regional/addons"
    require "scalingo/regional/apps"
    require "scalingo/regional/collaborators"
    require "scalingo/regional/containers"

    register_handlers!(
      addons: Addons,
      apps: Apps,
      collaborators: Collaborators,
      containers: Containers,
    )
  end
end
