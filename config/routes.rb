require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"

  post "/images/upload", to: "uploads#image"

  post "/graphql", to: "graphql#execute"
end
