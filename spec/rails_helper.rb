ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
require "rspec/rails"
require "simplecov"
require "spec_helper"

SimpleCov.start "rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }
