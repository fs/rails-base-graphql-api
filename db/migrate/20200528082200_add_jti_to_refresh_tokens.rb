class AddJtiToRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :refresh_tokens, :jti, :string, index: true

    add_index :refresh_tokens, :jti
  end
end
