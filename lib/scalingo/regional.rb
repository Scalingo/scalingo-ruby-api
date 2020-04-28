require "scalingo/api/base_client"

module Scalingo
  class Regional < API::BaseClient
    require "scalingo/regional/addon_categories"
    require "scalingo/regional/addon_providers"
    require "scalingo/regional/container_sizes"

    def addon_categories
      @addon_categories ||= AddonCategories.new(self)
    end

    def addon_providers
      @addon_providers ||= AddonProviders.new(self)
    end

    def container_sizes
      @container_sizes ||= ContainerSizes.new(self)
    end
  end
end
