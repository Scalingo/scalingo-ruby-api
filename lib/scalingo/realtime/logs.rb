require 'faye/websocket'
require 'eventmachine'

module Scalingo
  module Realtime
    class Logs
      attr_reader :app

      def initialize(app)
        @app = app
        @callbacks = []
      end

      def each_line(&block)
        @callbacks << block
      end

      def start
        each_line(&Proc.new) if block_given?

        EM.run do
          ws = Faye::WebSocket::Client.new(url)

          ws.on :open do |event|
          end

          ws.on :message do |event|
            data = JSON.parse(event.data)
            @callbacks.each { |c| c.call(data['log']) } if data['event'] == 'log'
          end

          ws.on :close do
            ws = nil
          end

          Signal.trap('INT')  { EM.stop }
          Signal.trap('TERM') { EM.stop }
        end
      end

      protected

      def url
        url = app.logs_url.gsub(/^http/, 'ws')
        return "#{url}&stream=true"
      end
    end
  end
end

