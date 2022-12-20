require "scalingo/api/client"

module Scalingo
  class RegionalDatabaseAPI < API::Client
    require "scalingo/regional_database/databases"
    require "scalingo/regional_database/backups"

    register_handlers!(
      databases: Databases,
      backups: Backups,
    )
  end
end
