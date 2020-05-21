require "rails_helper"

describe SignupUser do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        CreateUser,
        GenerateTokenPair
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
