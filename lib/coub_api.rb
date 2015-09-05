require 'coub_api/version'

require 'multi_json'
require 'faraday'

module CoubApi
  API_URL = 'http://coub.com/api'
  API_VERSION =  2
  AUTH_URL = 'http://coub.com/oauth/authorize'

  def self.authorization_url(client_id:, redirect_uri:, scope: [])
    opts = {response_type: :code}
    opts[:client_id] = client_id
    opts[:redirect_uri] = redirect_uri
    opts[:scope] = scope.join('+') unless scope.empty?

    "#{AUTH_URL}?#{opts.map{|k,v| "#{k}=#{v}"}.join('&')}"
  end


  class Error < StandardError
    attr_reader :data

    def error_msg
      @data['error']
    end

    def initialize(data)
      @data = data
      super(error_msg)
    end
  end

  class Client
    def initialize(access_token = nil, api_version: API_VERSION)
      @access_token = access_token
      @api_version = api_version
    end

    attr_reader :security_options, :request_options, :response, :connection

    def make_request(method, http_method, request_params = {})
      api_version = request_params.delete(:api_version) || @api_version
      url = "#{CoubApi::API_URL}/v#{api_version}/#{method}.json"

      faraday_options = {request: {timeout: 150, open_timeout: 150}, url: url}
      connection = Faraday.new(faraday_options) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end

      request_params[:access_token] = @access_token if @access_token
      response = connection.send(http_method) do |request|
        request.params = request_params
      end

      json_data = MultiJson.load(response.body)
      if json_data.is_a? Hash
       raise Error, json_data if json_data['error']
      end
      json_data
    end

    def get(*methods, **hargs)
      make_request(methods.join('/'), __method__, **hargs)
    end

    def post(*methods, **hargs)
      make_request(methods.join('/'), __method__, **hargs)
    end

    def method_missing(name, **hargs)
      get(name, **hargs)
    end
  end
end