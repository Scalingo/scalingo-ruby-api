require "scalingo/api/base_client"

module Scalingo
  class Regional < API::BaseClient
    require "scalingo/regional/addons"
    require "scalingo/regional/apps"
    require "scalingo/regional/container_sizes"

    def addons
      @addons ||= Addons.new(self)
    end

    def apps
      @apps ||= Apps.new(self)
    end

    def container_sizes
      @container_sizes ||= ContainerSizes.new(self)
    end
  end
end
