class Video < ApplicationRecord
  validates :video_id, presence: true, length: { maximum: 255 }
  validates :video_title, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :thumbnail_url, presence: true, length: { maximum: 255 }
end
