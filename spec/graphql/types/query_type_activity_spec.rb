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
  let(:query) do
    <<-GRAPHQL
      query {
        activities {
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
    GRAPHQL
  end

  it_behaves_like "graphql request", "gets activities list" do
    let(:fixture_path) { "json/acceptance/graphql/query_type_activities.json" }
    let(:prepared_fixture_file) { fixture_file.gsub(/:id|:user_id/, ":id" => activity.id, ":user_id" => user.id) }
  end
end
