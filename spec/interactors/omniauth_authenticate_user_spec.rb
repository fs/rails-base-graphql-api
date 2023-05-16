require "rails_helper"

describe OmniauthAuthenticateUser do
  include_context "with interactor"

  let(:initial_context) do
    { auth_code: auth_code }
  end

  let!(:user) { create(:user, email: "user@flatstack.com", password: "password") }

  describe ".call" do
    let(:expected_context) { Interactor::Context.new(user: user) }

    context "with Google auth" do
      let(:auth_code) { "token" }

      before do
        allow(AuthenticateByGoogleAuthCode).to receive(:call).and_return(expected_context)
      end

      it_behaves_like "success interactor"

      it "provides user instance" do
        expect(AuthenticateByGoogleAuthCode)
          .to receive(:call).with(auth_code: auth_code)

        interactor.run
      end
    end
  end
end
