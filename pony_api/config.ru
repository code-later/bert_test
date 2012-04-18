$:.unshift File.dirname(__FILE__)

require "rubygems"
require "bundler/setup"

require "app/pony_api"

run PonyApi
