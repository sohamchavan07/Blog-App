class Comment < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :user

  scope :ordered, -> { order(created_at: :asc) }

  after_create_commit { broadcast_append_to [ post, :comments ], target: "comments" }
end
