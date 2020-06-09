require "rails_helper"

describe Types::QueryType do
  let!(:activity) { create(:activity) }
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
    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:id|:title|:body|:created_at/,
        ":id" => activity.id,
        ":title" => activity.title,
        ":body" => activity.body,
        ":created_at" => activity.created_at.iso8601
      )
    end
  end
end
