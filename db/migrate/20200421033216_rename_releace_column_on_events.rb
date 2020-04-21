class RenameReleaceColumnOnEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :releace, :release
  end
end
