# This file is used by Rack-based servers to start the application.
require 'rack-mini-profiler'

require ::File.expand_path('../config/environment', __FILE__)
#use Rack::MiniProfiler
run Rails.application
