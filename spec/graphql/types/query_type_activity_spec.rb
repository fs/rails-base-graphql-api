require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  let!(:activity) do
    create(:activity,
           title: "User registered",
           body: "New user registered with the next attributes: First Name - John, Last Name - Doe")
  end
  let(:query) do
    <<-GRAPHQL
      query {
        activities {
          id
          title
          body
          createdAt
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "gets activities list" do
    let(:fixture_path) { "json/acceptance/graphql/query_type_activities.json" }
    let(:prepared_fixture_file) { fixture_file.gsub(/:id/, ":id" => activity.id) }
  end
end
