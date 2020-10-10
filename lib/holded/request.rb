module Holded
  class Request

    attr_accessor :api_key

    def initialize(api_key: nil, api_version: 'v1')
      @path_parts  = []
      @api_key     = api_key || self.class.api_key || ENV['HOLDED_API_KEY']
      @api_version = api_version
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
      @path_parts << @api_version if @path_parts.length == 1
      self
    end

    def path
      @path_parts.join('/')
    end

    def create(params: nil)
      APIRequest.new(builder: self).post(params: params)
    ensure
      reset_path_parts
    end

    def update(params: nil, body: nil)
      APIRequest.new(builder: self).put(params: params)
    ensure
      reset_path_parts
    end

    def search(params: nil)
      APIRequest.new(builder: self).get(params: params)
    ensure
      reset_path_parts
    end

    def delete(params: nil)
      APIRequest.new(builder: self).delete(params: params)
    ensure
      reset_path_parts
    end

    protected

    def reset_path_parts
      @path_parts = []
    end

  end
end