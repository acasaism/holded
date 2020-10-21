require 'json'
require 'holded/api_request'
require 'exceptions/exceptions'
require 'holded/request'
require 'holded/response'

module Holded

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

  end

  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = 'API_KEY'
    end

  end

end
