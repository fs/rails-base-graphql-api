require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  let(:user) { create(:user, email: "john.doe@email.me", first_name: "John", last_name: "Doe") }
  let!(:activity) do
    create(:activity,
           user: user,
           title: "User registered",
           body: "New user registered with the next attributes: First Name - John, Last Name - Doe",
           event: :user_registered)
  end
  let!(:activity_2) do
    create(:activity,
           user: user,
           title: "User Logged in",
           body: "User logged in",
           event: :user_logged_in)
  end
  let!(:activity_3) do
    create(:activity,
           user: user,
           title: "User Logged in",
           body: "User logged in",
           event: :user_logged_in)
  end
  let!(:private_activity) do
    create(:activity,
           user: user,
           title: "User updated",
           body: "New user updated with the next attributes: First Name - John, Last Name - Doe",
           event: :user_updated)
  end

  context "when first activity" do
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
                event
                createdAt
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

    it_behaves_like "graphql request", "get first activity" do
      let(:fixture_path) { "json/acceptance/graphql/first_page_query_type_activities.json" }
      let(:prepared_fixture_file) { fixture_file.gsub(/:id|:user_id/, ":id" => activity.id, ":user_id" => user.id) }
    end
  end

  context "when activity after cursor" do
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
                event
                createdAt
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

    it_behaves_like "graphql request", "get second activity" do
      let(:fixture_path) { "json/acceptance/graphql/second_page_query_type_activities.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:first_id|:second_id|:user_id/,
          ":first_id" => activity_2.id,
          ":second_id" => activity_3.id,
          ":user_id" => user.id
        )
      end
    end
  end

  context "with authorized user" do
    let!(:user) { create(:user, :with_data) }
    let(:token_payload) { { type: "access" } }

    it_behaves_like "graphql request", "includes user private activities to result" do
      let(:schema_context) { { current_user: user, token_payload: token_payload.stringify_keys } }
      let(:fixture_path) { "json/acceptance/graphql/authorized_query_type_activities.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id_1|:id_2|:id_3|:id_4|:user_id|:email|:first_name|:last_name/,
          ":id_1" => activity.id,
          ":id_2" => activity_2.id,
          ":id_3" => activity_3.id,
          ":id_4" => private_activity.id,
          ":user_id" => user.id,
          ":email" => user.email,
          ":first_name" => user.first_name,
          ":last_name" => user.last_name
        )
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
                  createdAt
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
    end
  end
end
