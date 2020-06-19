require "rails_helper"

describe SignupUser do
  describe "#after" do
    let(:created_user_id) { 213_689 }
    let(:user) { create :user, id: created_user_id }
    let(:initial_context) { { user: user } }

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it "schedules create activity job" do
        expect { interactor.run }.to have_enqueued_job(RegisterActivityJob)
          .with(created_user_id)
          .on_queue("events")
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
