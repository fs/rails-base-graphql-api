class ApplicationSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Execution::Interpreter
  use GraphQL::Pagination::Connections
  use GraphQL::Analysis::AST
end
