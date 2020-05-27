if defined?(GraphiQL)
  GraphiQL::Rails.config.headers["Authorization"] = lambda do |context|
    "Bearer #{context.cookies['_graphql_token']}"
  end
end
