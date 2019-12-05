require_relative 'realtime/logs'

module Scalingo
  class Logs < Client
    attr_reader :app

    def initialize(app)
      @app = app
      super()
    end

    def dump(lines = 10)
      get('', n: lines)
    end

    def realtime
      Scalingo::Realtime::Logs.new(app)
    end

    protected

    def request(method, path, options)
      endpoint, query = app.logs_url.split('?')
      log_token = query.split('=').last
      options.merge!(token: log_token, endpoint: endpoint)
      super(method, path, options)
    end
  end
end
