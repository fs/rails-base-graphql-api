shared_examples "succeed graphql request" do
  let(:response) { ApplicationSchema.execute(query).as_json }

  it "succeeds" do
    expect(response["errors"]).to be_blank
  end
end
