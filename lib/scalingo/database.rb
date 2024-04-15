require "scalingo/api/client"

module Scalingo
  class Database < API::Client
    require "scalingo/database/databases"
    require "scalingo/database/backups"

    register_handlers!(
      databases: Databases,
      backups: Backups
    )
  end
end
