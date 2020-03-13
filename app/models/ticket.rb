class Ticket < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :user_id, presence: true
end
