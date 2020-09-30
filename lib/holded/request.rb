module Holded
  class Request
    
    attr_accessor :api_key

    def initialize(api_key: nil)
      @path_parts = []
      @api_key = api_key || self.class.api_key || ENV['HOLDED_API_KEY']
    end

    ##
    # Si el method no está definido lo extraemos y lo incluimos en el path
    # si tiene argumentos los añadimos al path
    #
    # Ejemplo:
    # Holded::Request.new.contacts.create
    # 'contacts' será parte del path_parts
    # #

    def method_missing(method, *args)
      @path_parts << method.to_s.gsub("_", "-").downcase
      @path_parts << args if args.length > 0
      self
    end

    def create(params: nil, headers: nil, body: nil)
      APIRequest.new(builder: self).post(params: params, headers: headers, body: body)
    ensure
      reset_path_parts
    end

    def update(params: nil, headers: nil, body: nil)
      APIRequest.new(builder: self).patch(params: params, headers: headers, body: body)
    ensure
      reset_path_parts
    end

    def upsert(params: nil, headers: nil, body: nil)
      APIRequest.new(builder: self).put(params: params, headers: headers, body: body)
    ensure
      reset_path_parts
    end

    def retrieve(params: nil, headers: nil)
      APIRequest.new(builder: self).get(params: params, headers: headers)
    ensure
      reset_path_parts
    end

    def delete(params: nil, headers: nil)
      APIRequest.new(builder: self).delete(params: params, headers: headers)
    ensure
      reset_path_parts
    end
    
    protected
    
    def reset_path_parts
      @path_parts = []
    end
    
  end
end