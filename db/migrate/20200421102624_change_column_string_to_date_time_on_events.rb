class ChangeColumnStringToDateTimeOnEvents < ActiveRecord::Migration[5.2]
  def change
    change_column_default :events, :held_on, from: -> {""}, to: -> {%Q(CURRENT_DATE + interval '1day')}
    change_column :events, :held_on, 'date USING CAST(held_on AS date)'
    change_column_default :events, :started_at, from: -> {""}, to: nil
    change_column :events, :started_at, 'time USING CAST(started_at AS time)'
    change_column_default :events, :closed_at, from: -> {""}, to: nil
    change_column :events, :closed_at, 'time USING CAST(closed_at AS time)'
  end
end
