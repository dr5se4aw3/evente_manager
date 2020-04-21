class ChangeColumnNullTrueOnEvents < ActiveRecord::Migration[5.2]
  def change
    change_column_null :events, :event_image, true
  end
end
