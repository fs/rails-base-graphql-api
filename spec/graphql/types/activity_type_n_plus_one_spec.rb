require "rails_helper"

describe Types::ActivityType do
  let!(:user) { create(:user) }

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

  it_behaves_like "succeed graphql request"

  context "when N+1", :n_plus_one do
    populate { |n| create_list(:activity, n, user: user) }

    include_examples "performs constant number of queries request"
  end
end
