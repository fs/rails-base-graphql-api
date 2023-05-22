class AddConfirmedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmed_at, :datetime, precision: 6
  end
end
