require "rails_helper"

describe "Upload image", type: :request do
  let(:avatar_image_path) { Rails.root.join("spec/fixtures/images/avatar.jpg") }
  let(:file_key) { "c379cbc5050227055116049764dc283b.png" }
  let(:storage_key) { "cache" }
  let(:params) do
    {
      key: "#{storage_key}/#{file_key}",
      content_disposition: "inline; filename='avatar.png'; filename*=UTF-8''avatar.png",
      content_type: "image/png",
      content_length_range: "0..10485760",
      file: fixture_file_upload(avatar_image_path, "image/png")
    }
  end

  before { post "/images/upload", params: params }

  after { Shrine.storages[:cache].clear! }

  it "uploads image" do
    expect(Shrine.storages[:cache].store).to have_key(file_key)
  end

  it "returns 204 status" do
    expect(response).to have_http_status(:no_content)
    expect(response.body).to be_empty
  end
end
