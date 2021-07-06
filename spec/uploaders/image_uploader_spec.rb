require "rails_helper"

describe ImageUploader do
  let(:user) { build(:user) }

  before do
    user.avatar = File.open(Rails.root.join(image_path), "rb")
    user.save
  end

  context "with valid data" do
    let(:image_path) { "spec/fixtures/images/avatar.jpg" }
    let(:avatar) { user.avatar }

    it "saves avatar data" do
      expect(user).to be_persisted
      expect(avatar.mime_type).to eq("image/jpeg")
      expect(avatar.extension).to eq("jpg")
      expect(avatar.size).to be_instance_of(Integer)
    end
  end

  context "with wrong extension and mime type" do
    let(:image_path) { "spec/fixtures/files/test.txt" }
    let(:error_messages) do
      {
        avatar: [
          "type must be one of: image/jpeg, image/png, image/webp",
          "extension must be one of: jpg, jpeg, png, webp"
        ]
      }
    end

    it "raises error" do
      expect(user).not_to be_persisted
      expect(user.errors.messages).to eq(error_messages)
    end
  end

  context "with wrong mime type" do
    let(:image_path) { "spec/fixtures/files/fake_image.png" }
    let(:error_messages) do
      {
        avatar: [
          "type must be one of: image/jpeg, image/png, image/webp"
        ]
      }
    end

    it "raises error" do
      expect(user).not_to be_persisted
      expect(user.errors.messages).to eq(error_messages)
    end
  end
end
