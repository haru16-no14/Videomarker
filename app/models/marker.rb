class Marker < ApplicationRecord
  belongs_to :user
  belongs_to :video
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :time, presence: true
  
  has_many :markers
  has_many :users, through: :markers
end
