require "rails_helper"

describe PresignAvatar do
  include_context "with interactor"

  let(:initial_context) { { filename: filename, type: file_type } }
  let(:filename) { "avatar.png" }

  describe ".call" do
    context "with valid data" do
      let(:file_type) { "image/png" }
      let(:s3_storage) { instance_double("S3Storage", presign: presign_data) }
      let(:presign_data) { { foo: :bar } }

      before do
        allow(Shrine).to receive(:find_storage).and_return(s3_storage)
      end

      it_behaves_like "success interactor"
    end

    context "with invalid data" do
      let(:file_type) { "wrong_type" }
      let(:error_data) do
        { message: "Wrong file type", status: 415, code: :unsupported_media_type }
      end

      it_behaves_like "failed interactor"
    end
  end
end
