class BackfillEventInActivities < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def up
    Activity.in_batches { |relation| relation.update_all(event: "user_registered") }
  end
end
