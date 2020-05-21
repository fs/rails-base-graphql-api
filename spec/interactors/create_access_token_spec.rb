require "rails_helper"

describe CreateAccessToken do
  include_context "with interactor"

  let(:initial_context) { { user: user } }

  let(:user) { create :user }
  let(:payload) { { sub: user.id, exp: 1.hour.from_now.to_i } }
  let(:access_token) { JWT.encode(payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates access token for user" do
      interactor.run

      expect(context.access_token).to eq(access_token)
    end
  end
end
