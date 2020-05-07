shared_examples "success interactor" do
  it "succeeds" do
    interactor.run

    expect(context).to be_success
  end
end
