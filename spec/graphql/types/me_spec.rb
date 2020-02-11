require "rails_helper"

RSpec.describe Types::QueryType do
  let(:response) { ApplicationSchema.execute(query, query_options).as_json }

  let(:query_options) do
    { context: { current_user: user } }
  end

  let(:user) { create :user }

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

  let(:expected_response) do
    {"data" =>
      { "me"=>
        { "id"=> user.id.to_s,
          "email"=> user.email,
          "firstName"=> user.first_name,
          "lastName"=> user.last_name
        }
      }
    }
  end

  context "with current_user provided" do
    it "gets current_user info" do
      expect(response).to eq expected_response
    end
  end
end
