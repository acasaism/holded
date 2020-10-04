require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module Holded
  class APIRequest

    BASE_API_URL = 'https://api.holded.com/api/'

    def initialize(builder:)
      @request_builder = builder
      @url             = build_api_url
      @http            = build_http
    end

    def get(params: nil)
      validate_api_key
      request = Net::HTTP::Get.new(@url, build_headers)
      request = configure_request(request: request, params: params)
      @http.request(request)
    end

    def post(params: nil)
      validate_api_key
      request = Net::HTTP::Post.new(@url, build_headers)
      request = configure_request(request: request, params: params)
      @http.request(request)
    end

    def put(params: nil)
      validate_api_key
      request = Net::HTTP::Put.new(@url, build_headers)
      request = configure_request(request: request, params: params)
      @http.request(request)
    end

    def delete(params: nil)
      validate_api_key
      request = Net::HTTP::Delete.new(@url, build_headers)
      request = configure_request(request: request, params: params)
      @http.request(request)
    end


    private

    def build_api_url
      URI(BASE_API_URL + @request_builder.path)
    end

    def build_http
      http             = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def build_headers
      {
          "key"          => api_key,
          "Content-Type" => "application/json"
      }
    end

    def configure_request(request:, params: nil)
      request.body = params.to_json if params
      request
    end

    protected

    def validate_api_key
      api_key = self.api_key
      raise Exceptions::APIKeyNotFoundError, 'You must set an api_key' unless api_key
    end

    def api_key
      @request_builder.api_key
    end

  end
end