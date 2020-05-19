class CreateRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, null: false
      t.references :user, index: true, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
