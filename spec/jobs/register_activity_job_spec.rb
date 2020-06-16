require "rails_helper"

describe RegisterActivityJob do
  include ActiveJob::TestHelper

  let!(:user) { create :user }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  it "matches with enqueued job" do
    expect { described_class.perform_later(user.id) }
      .to have_enqueued_job(described_class)
  end
end
