module Holded
  class APIRequest

    def initialize(builder:)
      @request_builder = builder
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
    
    
  end
end