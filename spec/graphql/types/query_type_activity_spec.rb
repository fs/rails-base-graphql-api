require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  let(:user) { create(:user, email: "john.doe@email.me", first_name: "John", last_name: "Doe") }
  let!(:user_registred_activity) do
    create(:activity,
           user: user,
           title: "User registered",
           body: "New user registered with the next attributes: First Name - John, Last Name - Doe",
           event: :user_registered)
  end
  let!(:another_user_registred_activity) do
    create(:activity,
           title: "User registered",
           body: "New user registered with the next attributes: First Name - Will, Last Name - Smith",
           event: :user_registered)
  end

  before do
    create(:activity, user: user, title: "User Logged in", event: :user_logged_in, body: "User logged in")
    create(:activity, user: user, title: "User updated", event: :user_updated,
                      body: "New user updated with the next attributes: First Name - John, Last Name - Doe")
  end

  context "when first N activities" do
    let(:query) do
      <<-GRAPHQL
        query {
          activities(first: 1) {
            edges {
              cursor
              node {
                id
                title
                body
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

    it_behaves_like "graphql request", "get first activity" do
      let(:fixture_path) { "json/acceptance/graphql/first_page_query_type_activities.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => user_registred_activity.id
        )
      end
    end
  end

  context "with first N activities and cursor" do
    let(:query) do
      <<-GRAPHQL
        query {
          activities(first: 2, after: "MQ") {
            edges {
              cursor
              node {
                id
                title
                body
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

    it_behaves_like "graphql request", "get second activity" do
      let(:fixture_path) { "json/acceptance/graphql/second_page_query_type_activities.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => another_user_registred_activity.id
        )
      end
    end
  end
end
