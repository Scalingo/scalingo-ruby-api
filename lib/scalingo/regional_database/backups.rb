require "scalingo/api/endpoint"

module Scalingo
  class RegionalDatabase::Backups < API::Endpoint
    def for(addon_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "databases/#{addonn_id}/backups",
        data,
        headers,
        &block
      )

      unpack(:addons) { response }
    end

    def find(addon_id, backup_id, headers = nil, &block)
      data = nil

      response = connection.get(
        "databases/#{addon_id}/backups/#{backup_id}",
        data,
        headers,
        &block
      )

      unpack(:backup) { response }
    end
  end
end
