require "rails_helper"

describe Mutations::UpdateUser do
  let(:schema_context) { { current_user: user } }
  let(:user) { create :user, password: "123456" }
  let(:uploader) { ImageUploader.new(:cache) }
  let(:avatar_image_path) { Rails.root.join("spec/fixtures/images/avatar.jpg") }
  let(:uploaded_file) { uploader.upload(File.open(avatar_image_path, binmode: true)) }
  let(:avatar_id) { uploaded_file.id }

  let(:query) do
    <<-GRAPHQL
      mutation {
        updateUser (
          input: {
            email: "new_email_11@example.com",
            firstName: "Randle",
            lastName: "McMurphy",
            currentPassword: "123456",
            password: "qwerty",
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
          id
          email
          firstName
          lastName
          avatarUrl
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns updated user info" do
    let(:fixture_path) { "json/acceptance/graphql/update_user.json" }

    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:id|:avatar_url/,
        ":id" => user.id,
        ":avatar_url" => user.avatar.url
      )
    end
  end
end
