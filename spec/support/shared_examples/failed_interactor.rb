shared_examples "failed interactor" do
  it "failures" do
    interactor.run

    expect(context).to be_failure
    expect(context.error_data).to eq(error_data)
  end
end
