Rails.application.configure do
  config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.{rb,yml}")]
end
