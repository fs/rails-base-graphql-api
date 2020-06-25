require "rails_helper"

describe UpdateUser do
  describe ".call" do
    include_context "with interactor"

    let(:user) { create :user, password: "123456" }
    let(:initial_context) { { user: user, user_params: user_params } }

    context "with valid data" do
      let(:user_params) { { email: "dent@gmail.com", first_name: "Arthur", last_name: "Dent" } }
      let(:user_id) { user.id }

      it_behaves_like "success interactor"

      it "updates user" do
        interactor.run

        expect(user).to have_attributes(
          email: "dent@gmail.com",
          first_name: "Arthur",
          last_name: "Dent"
        )
      end

      it_behaves_like "activity source"
    end

    context "when updating password" do
      let(:user_params) { { current_password: "123456", password: "qwerty" } }

      it_behaves_like "success interactor"

      it "updates password" do
        interactor.run

        expect(user.authenticate("qwerty")).to be_truthy
      end
    end

    context "when no old password provided" do
      let(:user_params) { { password: "qwerty" } }
      let(:error_data) do
        {
          message: "Record Invalid",
          detail: ["Current password is incorrect", "Current password can't be blank"]
        }
      end

      it_behaves_like "failed interactor"
    end

    context "when wrong old password provided" do
      let(:user_params) { { current_password: "123457", password: "qwerty" } }
      let(:error_data) { { message: "Record Invalid", detail: ["Current password is incorrect"] } }

      it_behaves_like "failed interactor"
    end
  end
end
