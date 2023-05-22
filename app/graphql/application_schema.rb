require "graphql/batch"

class ApplicationSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Batch
  use GraphQL::PersistedQueries,
      compiled_queries: true,
      store: :redis_with_local_cache,
      redis_client: -> { RedisClient.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1")) }

  max_complexity 250
  max_depth 10
  default_max_page_size 25

  rescue_from(ActiveRecord::RecordNotFound) do |_err, _obj, _args, _ctx, field|
    raise GraphQL::ExecutionError.new("#{field.type.unwrap.graphql_name} not found",
                                      extensions: { message: "Not Found", status: 404, code: :not_found })
  end
end
