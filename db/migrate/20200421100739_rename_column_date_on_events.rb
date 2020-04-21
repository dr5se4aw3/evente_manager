class RenameColumnDateOnEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :date, :held_on
  end
end
