class CreateRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, index: true,  null: false
      t.references :user, foreign_key: true, null: false
      t.datetime :expires_at, null: false, precision: 6
      t.string :client_uid, index: true

      t.timestamps
    end
  end
end
