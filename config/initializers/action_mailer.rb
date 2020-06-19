Rails.application.configure do
  # Set default From address for all Mailers
  config.action_mailer.default_options = { from: ENV.fetch("MAILER_SENDER_ADDRESS") }
end
