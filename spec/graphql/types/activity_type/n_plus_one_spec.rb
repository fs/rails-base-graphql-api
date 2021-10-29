require "rails_helper"

describe Types::ActivityType, :n_plus_one do
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

  include_examples "performs constant number of queries request"
end
