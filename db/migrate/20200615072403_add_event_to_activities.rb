class AddEventToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :event, :string
  end
end
