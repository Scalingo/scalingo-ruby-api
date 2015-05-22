require 'active_support/inflector'

require_relative 'scalingo/error'
require_relative 'scalingo/configuration'
require_relative 'scalingo/api'
require_relative 'scalingo/client'
require_relative 'scalingo/logs'
require_relative 'scalingo/version'

module Scalingo
  extend Configuration

  def self.client(options = {})
    Scalingo::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end

