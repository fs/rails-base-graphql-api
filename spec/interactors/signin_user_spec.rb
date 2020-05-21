require "rails_helper"

describe SigninUser do
  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        AuthenticateUser,
        GenerateTokenPair
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
