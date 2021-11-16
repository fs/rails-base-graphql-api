require "rails_helper"

describe AuthenticateUser do
  include_context "with interactor"

  let(:initial_context) do
    { email: email, password: password }
  end

  let(:email) { "user@flatstack.com" }

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
  end
end
