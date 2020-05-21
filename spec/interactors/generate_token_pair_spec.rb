require "rails_helper"

describe GenerateTokenPair do
  include_context "with interactor"

  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        CreateAccessToken,
        CreateRefreshToken
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
