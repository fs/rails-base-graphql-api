class RemoveClientUidFromRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    remove_column :refresh_tokens, :client_uid
  end
end
