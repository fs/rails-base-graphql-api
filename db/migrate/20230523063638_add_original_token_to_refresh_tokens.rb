class AddOriginalTokenToRefreshTokens < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :refresh_tokens, :original_token, null: true,
      index: { unique: true, algorithm: :concurrently }
  end
end
