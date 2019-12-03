module Scalingo
  # Custom error class for rescuing from all Scalingo errors
  class Error < StandardError; end

  # Raised when the client tries a connection without any token
  class MissingToken < Error; end

  # Raised when the client tries a connection without a region defined
  class MissingRegion < Error; end

  # Raise if the region named used is invalid, like if it doesn't exist
  class InvalidRegion < Error; end

  # Raised when Scalingo returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Scalingo returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Scalingo returns the HTTP status code 500
  class InternalServerError < Error; end
end
