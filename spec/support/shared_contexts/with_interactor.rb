shared_context "with interactor" do
  let(:interactor) { described_class.new(initial_context) }
  let(:executed_context) { described_class.call(initial_context) }
  let(:context) { interactor.context }
end
