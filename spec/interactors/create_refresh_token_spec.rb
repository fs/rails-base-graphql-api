require "rails_helper"

describe CreateRefreshToken do
  include_context "with interactor"

  let(:initial_context) { { user: user } }

  let(:user) { create :user }
  let(:payload) { { sub: user.id, client_uid: client_uid, exp: 30.days.from_now.to_i } }
  let(:refresh_token) { JWT.encode(payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }
  let(:saved_refresh_token) { RefreshToken.last }
  let(:refresh_token_attributes) do
    {
      user_id: user.id,
      token: refresh_token,
      client_uid: client_uid
    }
  end
  let(:client_uid) { "#{user.id}-qwerty54321" }

  before { allow(SecureRandom).to receive(:hex).and_return("qwerty54321") }

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates refresh token for user" do
      interactor.run

      expect(context.refresh_token).to eq(refresh_token)
      expect(RefreshToken.count).to eq(1)
      expect(saved_refresh_token.reload).to have_attributes(refresh_token_attributes)
    end
  end
end
