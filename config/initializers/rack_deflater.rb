Rails.application.configure do
  config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
end
