$: << File.dirname(__FILE__)

require 'lib/snitch'
require 'renee'

snitch = Snitch.new

run Renee.core {
  @snitch = snitch

  path('who') do
    get do
      halt @snitch.connected_clients.join(",")
    end
  end
}
