$: << File.dirname(__FILE__)

require 'lib/snitch'
require 'sinatra'

snitch = Snitch.new

get '/who' do
  snitch.connected_clients.join(",")
end

run Sinatra::Application
