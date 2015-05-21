module Scalingo
  # Custom error class for rescuing from all Scalingo errors
  class Error < StandardError; end

  # Raised when Scalingo returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Scalingo returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Scalingo returns the HTTP status code 500
  class InternalServerError < Error; end
end
