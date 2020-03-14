class Tag < ApplicationRecord
  has_many :taggings
  has_many :tickets, through: :taggings
  validates :name, uniqueness: true

  scope :highest_running_count, -> { where("running_count is not null").order(running_count: :desc).first }

end
