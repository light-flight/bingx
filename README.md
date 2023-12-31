# Bingx

Bingx Ruby API client

## Installation

```ruby
gem 'bingx' # in your Gemfile
```

## Usage

```ruby
client = Bingx::Client.new(
  api_key: '<your API KEY>',
  secret_key: '<your SECRET KEY>'
)

client.request(:get, '/openApi/swap/v2/quote/trades', symbol: 'BTC-USDT')

client.get_user_balance

client.trade_order_test(
  symbol: 'ETH-USDT',
  side: 'BUY',
  positionSide: 'LONG',
  type: 'MARKET',
  quantity: 5
)
```

## Development

* `bin/setup` to install dependencies
* `rake spec` to run the tests
* `bin/console` for an interactive prompt
---
* `bundle exec rake install` to install this gem onto your local machine

## Release

1. Update the version number in `version.rb`
2. Run `bundle exec rake release`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/light-flight/bingx.
