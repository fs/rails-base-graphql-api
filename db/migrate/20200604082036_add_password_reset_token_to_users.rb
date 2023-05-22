class AddPasswordResetTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime, precision: 6

    add_index :users, :password_reset_token
  end
end
