require 'uri'
require 'net/http'
require 'openssl'

module Holded
  class APIRequest

    BASE_API_URL = 'https://api.holded.com/api/'

    def initialize(builder:)
      @request_builder = builder
      @url             = build_api_url
      @http            = build_http
    end

    def get(params: nil)
      request = Net::HTTP::Get.new(@url, build_headers)
      @http.request(request)
    end

    def post(params: nil, body: nil)
      request = Net::HTTP::Post.new(@url, build_headers)
      @http.request(request)
    end

    def put(params: nil, body: nil)
      p '******Put ApiRequest'
      request = Net::HTTP::Put.new(@url, build_headers)
      @http.request(request)
    end

    def delete(params: nil)
      p '******Delete ApiRequest'
      request = Net::HTTP::Delete.new(@url, build_headers)
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

    protected

    def api_key
      @request_builder.api_key
    end

  end
end