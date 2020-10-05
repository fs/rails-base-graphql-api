require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"

  post "/images/upload", to: "uploads#image" unless Shrine.find_storage(:cache).respond_to?(:presign)

  post "/graphql", to: "graphql#execute"
end
