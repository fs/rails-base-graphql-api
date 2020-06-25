require "rails_helper"

describe CreateUserActivity do
  include_context "with interactor"

  let(:initial_context) { { user: user, event: :user_registered } }
  let(:user) { create(:user, first_name: "John", last_name: "Doe") }
  let(:activity) { user.activities.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates registered activity" do
      expect { interactor.run }.to change { user.activities.count }.by(1)

      expect(activity).to have_attributes(
        event: "user_registered",
        title: "User Registered",
        body: <<~TXT
          New user registered with the next attributes:
           First name - John,
           Last name - Doe
        TXT
      )
    end
  end
end
