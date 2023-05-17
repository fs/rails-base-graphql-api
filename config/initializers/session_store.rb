Rails.application.configure do
  # This also configures session_options for use below
  config.session_store :cookie_store, key: ENV.fetch("SESSION_STORE_KEY", "#{File.basename(Rails.root)}_session")

  # Required for all session management (regardless of session_store)
  config.middleware.use ActionDispatch::Cookies

  config.middleware.use config.session_store, config.session_options
end
