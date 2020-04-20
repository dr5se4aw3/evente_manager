class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :title, null:false, default: ""
      t.references :user, foreign_key: true
      t.string :date, null:false, default: ""
      t.string :started_at, null:false, default: ""
      t.string :closed_at, null:false, default: ""
      t.text :venue_name, null:false, default: ""
      t.text :venue_address, null:false, default: ""
      t.text :venue_url, null:false, default: ""
      t.text :event_image, null:false, default: ""
      t.text :note, null:false, default: ""
      t.boolean :releace, null:false, default: false
      t.timestamps
    end
  end
end
