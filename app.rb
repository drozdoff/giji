require 'rubygems'
require 'bundler'
require 'sinatra'
require 'json'

post '/payload' do
  push = JSON.parse(request.body.read);
  puts "I got some JSON: #{push.inspect}"
end

post '/test' do
  puts "Ping"
end
