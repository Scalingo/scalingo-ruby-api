require "scalingo/api/base_client"

module Scalingo
  class Regional < API::BaseClient
    require "scalingo/regional/addons"
    require "scalingo/regional/apps"
    require "scalingo/regional/collaborators"
    require "scalingo/regional/container_sizes"

    register_handlers!(
      addons: Addons,
      apps: Apps,
      collaborators: Collaborators,
      container_sizes: ContainerSizes,
    )
  end
end
