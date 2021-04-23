require "rails_helper"

describe Mutations::PresignData do
  let(:query) do
    <<-GRAPHQL
      mutation {
        presignData (
          input: {
            filename: "avatar.png",
            type: "#{file_type}"
          }
        ) {
          url
          fields {
            key
            value
          }
        }
      }
    GRAPHQL
  end

  context "with valid file type" do
    let(:file_type) { "image/png" }
    let(:s3_storage) { instance_double("S3Storage", presign: presign_data) }
    let(:presign_data) { { url: "http://some-url.com", fields: { key: :value } } }

    before do
      allow(Shrine).to receive(:find_storage).and_return(s3_storage)
    end

    it_behaves_like "graphql request", "returns data for direct upload" do
      let(:fixture_path) { "json/acceptance/graphql/presign_data.json" }
    end
  end

  context "with invalid file type" do
    let(:file_type) { "wrong_type" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/presign_data_wrong.json" }
    end
  end
end
