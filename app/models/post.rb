class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :cover_image
  has_rich_text :body

  enum :status, { draft: 0, published: 1 }, default: :draft

  after_initialize :set_defaults, if: :new_record?

  validates :title, presence: true
  validates :body, presence: true

  def reading_time
    words_per_minute = 200
    words = body.to_plain_text.split.size
    (words.to_f / words_per_minute).ceil
  end

  private

  def set_defaults
    self.views_count ||= 0
  end

  def tag_list
    tags.pluck(:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
