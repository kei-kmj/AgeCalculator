require 'bundler'
Bundler.require
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths << File.expand_path('../', __FILE__).to_s