require "scalingo/api/endpoint"

module Scalingo
  class RegionalDatabase::Backups < API::Endpoint
    def create(addon_id, headers = nil, &block)
      data = nil

      response = database_connection(addon_id).post(
        "databases/#{addon_id}/backups",
        data,
        headers,
        &block
      )

      unpack (:database_backup) { response }
    end

    def for(addon_id, headers = nil, &block)
      data = nil

      response = database_connection(addon_id).get(
        "databases/#{addon_id}/backups",
        data,
        headers,
        &block
      )

      unpack(:database_backups) { response }
    end

    def archive(addon_id, backup_id, headers = nil, &block)
      data = nil

      response = database_connection(addon_id).get(
        "databases/#{addon_id}/backups/#{backup_id}/archive",
        data,
        headers,
        &block
      )

      unpack { response }
    end
  end
end
