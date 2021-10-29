require "rails_helper"

describe Types::QueryType, :n_plus_one do
  let!(:user) { create :user }

  let(:query) do
    <<-GRAPHQL
      query {
        activities {
          edges {
            cursor
            node {
              id
              user {
                id
              }
            }
          }
        }
      }
    GRAPHQL
  end

  populate { |n| create_list :activity, n, user: user }

  specify do
    expect { ApplicationSchema.execute(query, {}).as_json }.to perform_constant_number_of_queries
  end
end
