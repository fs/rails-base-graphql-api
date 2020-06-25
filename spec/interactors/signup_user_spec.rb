require "rails_helper"

describe SignupUser do
  describe "#after" do
    let(:user_id) { 213_689 }
    let(:user) { create :user, id: user_id }
    let(:initial_context) { { user: user } }
    let(:event) { :user_registered }

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it_behaves_like "activity source" do
        let(:source) { interactor.run }
      end
    end

    context "when organizer failures" do
      include_context "with stubbed organizer", failure: true

      it "does not schedule create activity job" do
        expect { interactor.run }.not_to have_enqueued_job(RegisterActivityJob)
      end
    end
  end
end
