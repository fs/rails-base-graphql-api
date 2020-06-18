class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :event, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
