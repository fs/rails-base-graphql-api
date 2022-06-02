require "rails_helper"

describe Types::SquishedString do
  describe "#coerce_input" do
    subject { described_class.coerce_input(input_value, {}) }

    context "with regular string" do
      let(:input_value) { "String without extra whitespaces" }

      it { is_expected.to eq("String without extra whitespaces") }
    end

    context "with overspaced string" do
      let(:input_value) { "  String  with \t  extra \n whitespaces  " }

      it { is_expected.to eq("String with extra whitespaces") }
    end

    context "with not string provided" do
      let(:input_value) { 42 }

      it "raises graphql error" do
        expect { subject }.to raise_error(::GraphQL::CoercionError, "42 is not a valid string")
      end
    end
  end
end
