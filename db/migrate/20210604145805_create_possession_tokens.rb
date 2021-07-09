class CreatePossessionTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :possession_tokens do |t|
      t.string :value, null: false, unique: true

      t.belongs_to :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
