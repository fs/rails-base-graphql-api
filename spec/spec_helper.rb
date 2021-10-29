# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require "active_support/testing/time_helpers"
require "action_policy/rspec/dsl"

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end
