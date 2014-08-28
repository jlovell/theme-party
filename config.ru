require 'rubygems'
require 'bundler'

Bundler.require

require_relative 'party'
run Sinatra::Application
