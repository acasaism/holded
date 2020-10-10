require 'json'

module Holded
  class Response
    attr_accessor :status_code

    def initialize(request_response:)
      @request_response = request_response
      @status_code      = request_response.code
    end

    def body
      JSON.parse(@request_response.body)
    end
    
    def success?
      @request_response.kind_of? Net::HTTPSuccess
    end

  end
end