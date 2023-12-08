# frozen_string_literal: true

module Bingx
  module Requests
    module Account
      def get_user_balance
        request(:get, '/openApi/swap/v2/user/balance')
      end
    end
  end
end
