class Ticket < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :user_id, presence: true
  validate :maximum_tags

  # setup getter and setter for all_tags virtual attribute so we can "bulk save" (not really) tags on the ticket object
  def all_tags=(tags)
    tags.each do |name|
      tag = Tag.find_or_create_by(name: name.downcase)
      tag.increment!(:running_count, 1).save
      self.taggings.new(tag_id: tag.id).save
    end
  end

  def all_tags
    self.tags
  end

  private
    def maximum_tags
      errors.add(:all_tags, 'cannot be more than 5') if tag_count > 5
    end

    def tag_count
      self.all_tags.size
    end
end
