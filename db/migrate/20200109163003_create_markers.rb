class CreateMarkers < ActiveRecord::Migration[5.0]
  def change
    create_table :markers do |t|
      t.string :content
      t.string :time
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end
  end
end
