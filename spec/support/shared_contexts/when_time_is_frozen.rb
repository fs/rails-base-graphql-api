shared_context "when time is frozen" do
  let(:current_time) { Time.zone.local(2020, 5, 10, 12, 30) }

  before { travel_to(current_time) }
end
