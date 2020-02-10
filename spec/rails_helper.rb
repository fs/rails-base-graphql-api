ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
require "rspec/rails"

require "spec_helper"

Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }
