class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.datetime :time
      t.integer :time_card_id

      t.timestamps
    end
  end
end
