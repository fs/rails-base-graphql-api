require "rails_helper"

describe Mutations::SignUp do
  include_context "when time is frozen"

  before do
    allow(JWT).to receive(:encode).and_return("jwt.token.success")
  end

  let(:registered_user) { User.last }
  let(:uploader) { ImageUploader.new(:cache) }
  let(:avatar_image_path) { Rails.root.join("spec/fixtures/images/avatar.jpg") }
  let(:uploaded_file) { uploader.upload(File.open(avatar_image_path, binmode: true)) }
  let(:avatar_id) { uploaded_file.id }

  let(:query) do
    <<-GRAPHQL
      mutation {
        signUp(
          input: {
            email: "#{email}",
            password: "TheRing",
            avatar: {
              id: "#{avatar_id}",
              metadata: {
                size: 1098178,
                filename: "avatar.jpg",
                mimeType: "image/jpg"
              }
            }
          }
        ) {
          me {
            id
            email
            avatarUrl
          }
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    let(:email) { "bilbo.baggins@shire.com" }

    it_behaves_like "graphql request", "registers a new user" do
      let(:fixture_path) { "json/acceptance/graphql/sign_up.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:avatar_url|:accessToken|:refreshToken/,
          ":id" => registered_user.id,
          ":avatar_url" => registered_user.avatar.url,
          ":accessToken" => "jwt.token.success",
          ":refreshToken" => "jwt.token.success"
        )
      end
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/sign_up_wrong.json" }
    end
  end
end
