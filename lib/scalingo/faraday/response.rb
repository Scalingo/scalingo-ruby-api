require "faraday"
require "faraday/response"

# Some additional methods for Faraday::Response in order to enhance expressiveness
module Faraday
  class Response
    # @deprecated Use {#success?} instead
    def successful?
      success?
    end

    # @deprecated Use {#body} instead
    def data
      body
    end

    def client_error?
      RaiseError::ClientErrorStatuses.include?(status)
    end

    def server_error?
      RaiseError::ServerErrorStatuses.include?(status)
    end

    def error?
      !success?
    end
  end
end
