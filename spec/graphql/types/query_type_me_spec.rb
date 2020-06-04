require "rails_helper"

describe Types::QueryType do
  let!(:user) { create :user }

  let(:query) do
    <<-GRAPHQL
      query {
        me {
          id
          email
          firstName
          lastName
        }
      }
    GRAPHQL
  end

  context "with current_user provided" do
    it_behaves_like "graphql_request", "gets current_user info" do
      let(:schema_context) { { current_user: user } }
      let(:fixture_path) { "json/acceptance/graphql/query_type_me.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:email|:first_name|:last_name/,
          ":id" => user.id,
          ":email" => user.email,
          ":first_name" => user.first_name,
          ":last_name" => user.last_name
        )
      end
    end
  end
end
