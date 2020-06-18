shared_context "with mail delivery stubbed" do
  let(:delivery) { instance_double(ActionMailer::MessageDelivery) }

  before do
    allow(delivery).to receive(:deliver_later)
  end
end
