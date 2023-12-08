# frozen_string_literal: true

module Bingx
  class Client
    include HTTParty
    include Requests::Account
    include Requests::Trade

    attr_accessor :api_key, :secret_key, :base_url

    base_uri 'https://open-api.bingx.com'
    debug_output $stdout

    def initialize(api_key:, secret_key:)
      @api_key = api_key
      @secret_key = secret_key
      @base_url = 'https://open-api.bingx.com'
    end

    def request(method, endpoint, payload = {})
      public_send(method, endpoint, payload)
    end

    def get(endpoint, payload = {})
      headers = { 'X-BX-APIKEY': api_key }

      payload.merge!(timestamp: DateTime.now.strftime('%Q'))
      payload = HTTParty::HashConversions.to_params(payload)
      payload += "&signature=#{signature(payload)}"

      response = self.class.get(endpoint, query: payload, headers: headers)
      response.body
    end

    # rubocop:disable Metrics/AbcSize
    def post(endpoint, payload = {})
      payload.merge!(timestamp: DateTime.now.strftime('%Q'))
      params = parse_params(payload)
      full_url = URI("#{base_url}#{endpoint}?#{params}&signature=#{signature(params)}")

      https = Net::HTTP.new(full_url.host, full_url.port)
      https.set_debug_output($stdout)
      https.use_ssl = true

      request = Net::HTTP::Post.new(full_url)
      request['X-BX-APIKEY'] = api_key
      request['Content-Type'] = 'application/json'

      response = https.request(request)
      puts response.read_body
    end
    # rubocop:enable Metrics/AbcSize

    private

    def signature(payload)
      OpenSSL::HMAC.hexdigest('sha256', secret_key, payload)
    end

    def parse_params(params)
      params.keys.sort.map { |x| "#{x}=#{params[x]}" }.join('&')
    end
  end
end
