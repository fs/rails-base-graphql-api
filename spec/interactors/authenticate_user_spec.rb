require "rails_helper"

describe AuthenticateUser do
  include_context "with interactor"

  let(:initial_context) do
    { email: email, password: password, google_auth_code: google_auth_code }
  end

  let(:email) { "user@flatstack.com" }
  let(:google_auth_code) { nil }

  let!(:user) { create :user, email: "user@flatstack.com", password: "password" }

  describe ".call" do
    let(:expected_context) { Interactor::Context.new(user: user) }

    context "with classic auth" do
      let(:password) { "password" }

      before do
        allow(AuthenticateByEmailAndPassword).to receive(:call).and_return(expected_context)
      end

      it_behaves_like "success interactor"

      it "provides user instance" do
        expect(AuthenticateByEmailAndPassword)
          .to receive(:call).with(email: email, password: password)
        interactor.run

        expect(context.user).to eq(user)
      end
    end

    context "with valid credentials" do
      let(:password) { nil }
      let(:email) { nil }
      let(:google_auth_code) { "token" }

      before do
        allow(AuthenticateByGoogleAuthCode).to receive(:call).and_return(expected_context)
      end

      it_behaves_like "success interactor"

      it "provides user instance" do
        expect(AuthenticateByGoogleAuthCode)
          .to receive(:call).with(auth_code: google_auth_code)

        interactor.run
      end
    end

    context "with invalid credentials" do
      let(:password) { "wrong_password" }
      let(:error_data) do
        {
          message: "Invalid credentials",
          status: 401,
          code: :unauthorized
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
