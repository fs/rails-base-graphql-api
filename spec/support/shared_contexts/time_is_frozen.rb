shared_context "when time is frozen" do
  before { travel_to(Time.zone.local(2020, 5, 10, 12, 30)) }

  after { travel_back }
end
