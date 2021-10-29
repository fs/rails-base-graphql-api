# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require "active_support/testing/time_helpers"
require "n_plus_one_control/rspec"

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end
