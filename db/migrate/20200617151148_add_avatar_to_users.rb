class AddAvatarToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_data, :text
  end
end
