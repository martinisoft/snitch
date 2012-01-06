$: << File.dirname(__FILE__)

require 'snitch'
require 'renee'

snitch = Snitch.new

run Renee.core {
  @snitch = snitch

  path('who') do
    get do
      @snitch.update_client_list
      halt @snitch.connected_clients.join(",")
    end
  end
}
