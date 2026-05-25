class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :name, presence: true, uniqueness: true

  def self.popular(limit = 10)
    Rails.cache.fetch("popular_tags", expires_in: 1.hour) do
      joins(:taggings).group("tags.id").order("count(taggings.id) DESC").limit(limit).to_a
    end
  end
end
