shared_context "with stubbed organizer" do |options = {}|
  include_context "with interactor"

  before do
    allow(described_class).to receive(:organized).and_return([])
    allow(interactor).to receive(:context).and_call_original
    allow(interactor).to(receive(:run!).and_raise(Interactor::Failure)) if options[:failure]
  end
end
