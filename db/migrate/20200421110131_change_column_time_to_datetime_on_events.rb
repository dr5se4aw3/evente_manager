class ChangeColumnTimeToDatetimeOnEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :started_at, :time
    remove_column :events, :closed_at, :time
    remove_column :events, :held_on, :date
    add_column :events, :started_at, :timestamptz, null: false
    add_column :events, :closed_at, :timestamptz, null: false
  end
end
