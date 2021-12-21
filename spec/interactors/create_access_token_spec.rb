require "rails_helper"

describe CreateAccessToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, token_payload: token_payload } }
  let(:user) { create :user, id: 111_111 }

  describe ".call" do
    context "with existing jti" do
      let(:token_payload) { { jti: "existing_token_jti" } }
      let(:expected_jti) { "existing_token_jti" }
      let(:expected_token_payload) do
        {
          "sub" => 111_111,
          "exp" => 1_589_117_400,
          "jti" => "existing_token_jti",
          "type" => "access"
        }
      end

      it_behaves_like "success interactor"

      it "provides previous token jti" do
        interactor.run

        expect(context.jti).to eq(expected_jti)
      end

      it "generates access token with correct payload" do
        interactor.run

        expect(context.access_token).to have_jwt_token_payload(expected_token_payload)
      end
    end

    context "with generate jti" do
      let(:token_payload) { {} }
      let(:expected_jti) { "7fc6d21913811be48db74417f9a26598" }
      let(:expected_token_payload) do
        {
          "sub" => 111_111,
          "exp" => 1_589_117_400,
          "jti" => "7fc6d21913811be48db74417f9a26598",
          "type" => "access"
        }
      end

      it_behaves_like "success interactor"

      it "generates new access token jti" do
        interactor.run

        expect(context.jti).to eq(expected_jti)
      end

      it "generates access token with correct payload" do
        interactor.run

        expect(context.access_token).to have_jwt_token_payload(expected_token_payload)
      end
    end
  end
end
