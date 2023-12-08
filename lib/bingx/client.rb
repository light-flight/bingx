# frozen_string_literal: true

module Bingx
  class Client
    include HTTParty
    include Requests::Account

    attr_accessor :api_key, :secret_key, :recv_window

    base_uri 'https://open-api.bingx.com'
    debug_output $stdout

    def initialize(api_key:, secret_key:, recv_window: '5000')
      @api_key = api_key
      @secret_key = secret_key
      @recv_window = recv_window
    end

    def request(method, endpoint, payload = {})
      headers = { 'X-BX-APIKEY': api_key }
      params = build_params(payload)
      response = self.class.send(method, endpoint, query: params, headers: headers)
      response.body
    end

    private

    def build_params(payload)
      payload.merge!(
        recv_window: recv_window,
        timestamp: DateTime.now.strftime('%Q')
      )
      payload = HTTParty::HashConversions.to_params(payload)
      payload + "&signature=#{signature(payload)}"
    end

    def signature(payload)
      OpenSSL::HMAC.hexdigest('sha256', secret_key, payload)
    end
  end
end
