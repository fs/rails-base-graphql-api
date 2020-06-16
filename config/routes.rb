Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  mount Sidekiq::Web => "/sidekiq"
end
