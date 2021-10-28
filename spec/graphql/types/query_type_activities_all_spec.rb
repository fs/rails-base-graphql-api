require "rails_helper"

describe Types::QueryType do
  let(:user) { create(:user, email: "john.doe@email.me", first_name: "John", last_name: "Doe") }
  let!(:activity1) do
    create(:activity, user: user, title: "User registered", event: :user_registered,
                      body: "New user registered: First Name - John, Last Name - Doe")
  end
  let!(:activity2) do
    create(:activity, user: user, title: "User Logged in", body: "User logged in", event: :user_logged_in)
  end
  let!(:activity3) do
    create(:activity, user: user, title: "User Logged in", body: "User logged in", event: :user_logged_in)
  end

  let(:query) do
    <<-GRAPHQL
      query {
        activities {
          edges {
            cursor
            node {
              id
              title
              body
              event
              user {
                id
                email
                firstName
                lastName
              }
            }
          }
          pageInfo {
            endCursor
            startCursor
            hasPreviousPage
            hasNextPage
          }
        }
      }
    GRAPHQL
  end

  before do
    create(:activity, user: user, title: "User updated", event: :user_updated,
                      body: "New user updated: First Name - John, Last Name - Doe")
  end

  it_behaves_like "graphql request", "get activities list" do
    let(:fixture_path) { "json/acceptance/graphql/types/query_type_activities_all.json" }
    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:activity1_id|:activity2_id|:activity3_id|:user_id/,
        ":activity1_id" => activity1.id,
        ":activity2_id" => activity2.id,
        ":activity3_id" => activity3.id,
        ":user_id" => user.id
      )
    end
  end

  it_behaves_like "constant number of queries request"
end
