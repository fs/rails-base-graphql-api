class AddForeignKeyToOriginalTokenToRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      add_foreign_key :refresh_tokens, :refresh_tokens, column: :original_token_id
    end
  end
end
