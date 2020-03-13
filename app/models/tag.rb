class Tag < ApplicationRecord
  has_many :taggings
  has_many :tickets, through: :taggings
  validates :name, uniqueness: true
end
