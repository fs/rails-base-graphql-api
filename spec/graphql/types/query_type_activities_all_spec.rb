require "rails_helper"

describe Types::QueryType, :n_plus_one do
  let!(:user) { create :user }

  let(:response) { ApplicationSchema.execute(query, {}).as_json }

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
    expect { response }.to perform_constant_number_of_queries
  end
end
