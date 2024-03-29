require "rails_helper"

describe Types::QueryType do
  let(:schema_context) { { current_user: user } }
  let!(:user) { create(:user, :with_data) }

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

  context "with user" do
    it_behaves_like "graphql request", "gets current_user info" do
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

    context "with activities query" do
      let!(:activity) { create(:activity, user: user, event: :user_updated) }
      let(:query) do
        <<-GRAPHQL
          query {
            me {
              id
              email
              firstName
              lastName
              activities(events: [USER_UPDATED]){
                edges {
                  node {
                    id
                    event
                  }
                }
              }
            }
          }
        GRAPHQL
      end

      before do
        create(:activity, event: :user_updated)
      end

      it_behaves_like "graphql request", "gets current_user info" do
        let(:fixture_path) { "json/acceptance/graphql/query_type_me_with_activities.json" }
        let(:prepared_fixture_file) do
          fixture_file.gsub(
            /:id|:activity_id/,
            ":id" => user.id,
            ":activity_id" => activity.id
          )
        end
      end
    end
  end

  context "without user" do
    it_behaves_like "graphql request", "gets current_user info" do
      let(:schema_context) { { current_user: nil } }
      let(:fixture_path) { "json/acceptance/graphql/query_type_me_unauthorized.json" }
    end
  end
end
