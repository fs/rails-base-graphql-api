shared_examples "activity source" do
  it "schedules activity job" do
    expect { interactor.run }.to have_enqueued_job(RegisterActivityJob)
      .with(user_id, event)
      .on_queue("events")
  end
end
