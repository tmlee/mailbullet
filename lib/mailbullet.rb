require "mailbullet/version"
require 'mailbullet/email_validation'
require 'mailbullet/messages'

require 'faraday'
require 'json'


module Mailbullet

  class Client
    include Mailbullet::EmailValidation
    include Mailbullet::Messages

    BASE_URL = 'https://api.mailgun.net/'
    API_VERSION = 'v2'

    def initialize(keys={})
      @secret = keys[:secret]
      @public = keys[:public]
    end

    ## Init Helpers

    def self.public_client
      @client ||= Mailbullet::Client.new
    end

    def self.public_client=(mailbullet_client)
      @client ||= mailbullet_client
    end

    def self.secret_client
      @client ||= Mailbullet::Client.new
    end

    def self.secret_client=(mailbullet_client)
      @client ||= mailbullet_client
    end

    private

    def api_url
      BASE_URL + API_VERSION + '/'
    end

    def api_call(method_name, options, verb=:get)
      response = connection(method_name, options, verb)
      puts response.inspect
      parse_response response
    end

    def parse_response(response)
      #raise_errors response
      if response.body == " "
        {}
      else
        JSON.parse response.body
      end
    end

    def connection(method_name, options, verb)
      conn = Faraday.new(:url => api_url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      # Basic authentication 
      conn.basic_auth 'api', @secret || @public

      if verb == :put
        response = conn.put(method_name, options)
      elsif verb == :post
        response = conn.post(method_name, options)
      elsif verb == :delete
        response = conn.delete(method_name)
      else
        response = conn.get(method_name + "?" + to_query_params(options))
      end
    end


    def to_query_params(options)
      options.collect { |key, value| "#{key}=#{value}" }.join('&')
    end


  end

end