require "rails_helper"

describe UpdateTokenPair do
  include_context "with interactor"

  describe ".organized" do
    subject { described_class.organized }

    let(:expected_interactors) do
      [
        DeleteRefreshToken,
        CreateAccessToken,
        CreateRefreshToken
      ]
    end

    it { is_expected.to eq(expected_interactors) }
  end
end
