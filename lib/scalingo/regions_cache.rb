module Scalingo
  module RegionsCache
    def region_api_endpoint(name)
      @regions_cache ||= regions.all

      region = @regions_cache.select { |r| r.name == name }.first
      raise InvalidRegion, name if region.nil?

      return "#{region['api']}/v1"
    end
  end
end
