class AddCommentsCountToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false

    # Reset counter for existing posts
    up_only do
      Post.find_each do |post|
        Post.reset_counters(post.id, :comments)
      end
    end
  end
end
