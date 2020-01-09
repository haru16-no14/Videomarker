class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :video_title
      t.string :channel_title
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
