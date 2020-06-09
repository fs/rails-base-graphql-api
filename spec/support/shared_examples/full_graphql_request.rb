shared_examples "full graphql request" do |spec_name|
  let(:fixture_file) { File.read(File.join(RSpec.configuration.fixture_path, fixture_path)) }
  let(:parsed_fixture_file) do
    JSON.parse(respond_to?(:prepared_fixture_file) ? prepared_fixture_file : fixture_file)
  end

  it spec_name do
    expect(JSON.parse(response.body)).to eq(parsed_fixture_file)
  end
end
