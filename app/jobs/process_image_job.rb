class ProcessImageJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    if post.cover_image.attached?
      # Pre-generate common variants to speed up page loads
      post.cover_image.variant(resize_to_fill: [ 800, 400, { gravity: "Center" } ]).processed
    end
  end
end
