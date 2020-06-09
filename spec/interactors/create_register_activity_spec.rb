require "rails_helper"

describe CreateRegisterActivity do
  include_context "with interactor"

  let(:initial_context) { { user: user } }
  let(:user) { create(:user) }
  let(:activity) { user.activities.last }

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates activity" do
      expect { interactor.run }.to change(Activity, :count).by(1)

      expect(activity).to have_attributes(
        title: "User registered",
        body: <<~TXT
          New user registered with the next attributes:
            First name - #{user.first_name},
            Last name - #{user.last_name}
        TXT
      )
    end
  end
end
