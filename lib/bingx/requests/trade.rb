# frozen_string_literal: true

module Bingx
  module Requests
    module Trade
      def trade_order_test(payload)
        request(:post, '/openApi/swap/v2/trade/order/test', payload)
      end
    end
  end
end
