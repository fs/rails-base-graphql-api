class AddUniqIndexToTokenOnRefreshTokens < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    remove_index :refresh_tokens, :token
    add_index :refresh_tokens, :token, unique: true, algorithm: :concurrently
  end
end
