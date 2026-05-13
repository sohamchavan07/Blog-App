class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one_attached :cover_image
  has_rich_text :body

  attribute :status, :integer, default: 0
  attribute :slug, :string
  attribute :views_count, :integer, default: 0
  attribute :legacy_body, :text

  enum :status, { draft: 0, published: 1 }, default: :draft

  after_initialize :set_defaults, if: :new_record?

  validates :title, presence: true
  validates :body, presence: true

  def reading_time
    words_per_minute = 200
    content = begin
      body.to_plain_text
    rescue StandardError
      # Fallback to the legacy column if ActionText is broken or missing
      legacy_body.to_s
    end
    words = content.to_s.split.size
    [1, (words.to_f / words_per_minute).ceil].max
  end

  def summary
    begin
      # Trigger a load to catch potential database errors early
      body.to_s
      body
    rescue StandardError
      legacy_body.to_s
    end
  end

  def plain_text_summary
    begin
      body.to_plain_text
    rescue StandardError
      legacy_body.to_s
    end
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
