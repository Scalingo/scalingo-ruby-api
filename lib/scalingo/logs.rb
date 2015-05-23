require_relative 'realtime/logs'

module Scalingo
  class Logs < Client
    attr_reader :app

    def initialize(app)
      super({endpoint: ''})
      self.parse_json = false
      @app = app
    end

    def dump(lines = 10)
      get('', n: lines)
    end

    def realtime
      Scalingo::Realtime::Logs.new(app)
    end

    protected
    def log_token
      self.endpoint, log_token = app.logs_url.split('?')
      @log_token = log_token.split('=').last
    end

    def request(method, path, options)
      options.merge!(token: log_token)
      super(method, path, options)
    end
  end
end

