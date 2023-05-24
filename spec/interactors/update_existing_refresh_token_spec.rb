require "rails_helper"

describe UpdateExistingRefreshToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) do
    {
      existing_refresh_token: refresh_token,
      substitution_token: substitution_token
    }
  end
  let(:refresh_token) { create(:refresh_token) }
  let(:substitution_token) { create(:refresh_token, token: "subtoken") }

  describe ".call" do
    it "updates existing refresh token attributes" do
      interactor.run

      expect(refresh_token).to have_attributes(
        substitution_token: substitution_token,
        expires_at: "2020-05-10 12:31:00".to_datetime
      )
    end
  end
end
