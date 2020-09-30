require 'uri'
require 'net/http'
require 'openssl'

module Holded
  class APIRequest

    BASE_API_URL = 'https://api.holded.com/api/'

    def initialize(builder:)
      @request_builder = builder
      @http            = build_http
    end

    def get(params: nil, headers: nil)
      p '******Get ApiRequest'
    end

    def post(params: nil, headers: nil, body: nil)
      p '******POST ApiRequest'
    end

    def put(params: nil, headers: nil, body: nil)
      p '******Put ApiRequest'
    end

    def delete(params: nil, headers: nil)
      p '******Delete ApiRequest'
    end

    def patch(params: nil, headers: nil, body: nil)
      p '******Patch ApiRequest'
    end

    private

    def get_api_url
      URI(BASE_API_URL + @request_builder.path)
    end

    def build_http
      url              = get_api_url
      http             = Net::HTTP.new(url.host, url.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

  end
end