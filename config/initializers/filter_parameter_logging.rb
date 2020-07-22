# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]

Rails.application.config.filter_parameters << lambda do |param_name, value|
  value.gsub!(/[\r\n\"]+/, "") if %w[query].include?(param_name) & value.respond_to?(:gsub!)
end
