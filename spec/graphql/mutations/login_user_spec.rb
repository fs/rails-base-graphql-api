describe Mutations::LoginUser do
  let!(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }

  let(:token) { JWT.encode({ sub: user.id }, nil, "none") }

  context "with valid credentials" do
    let(:response) { ApplicationSchema.execute(query, {}).as_json }

    let(:query) do
      <<-GRAPHQL
        mutation {
          loginUser (
            email: "bilbo.baggins@shire.com",
            password: "TheRing"
          ) {
            user {
              email
              id
            }
          }
        }
      GRAPHQL
    end

    let(:expected_response) do
      {
        "data" => {
          "loginUser" => {
            "user" => {
              "id" => user.id.to_s,
              "email" => "bilbo.baggins@shire.com"
            }
          }
        }
      }
    end

    it "gets user token" do
      expect(response).to eq expected_response
    end
  end

  context "with invalid credentials" do
    let(:response) { ApplicationSchema.execute(query, {}).as_json }

    let(:query) do
      <<-GRAPHQL
        mutation {
          loginUser (
            email: "bilbo.baggins@shire.com",
            password: "Sauron"
          ) {
            user {
              id
              email
            }
          }
        }
      GRAPHQL
    end

    let(:expected_response) do
      { "data" =>
        { "loginUser" => nil },
          "errors" => [
          { "message" => "Invalid credentials",
            "locations" => [
              { "line" => 2, "column" => 11 }
            ],
            "path" => ["loginUser"]
          }
        ]
      }
    end

    it "gets errors message" do
      expect(response).to eq expected_response
    end
  end
end
