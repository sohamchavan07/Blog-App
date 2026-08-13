class AddIndexesForPerformance < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, :user_id unless index_exists?(:posts, :user_id)

    # Ensure unique slug index exists (name included to avoid duplicate name collisions)
    unless index_exists?(:posts, :slug, name: "index_posts_on_slug")
      add_index :posts, :slug, unique: true, name: "index_posts_on_slug"
    end

    add_index :posts, :created_at unless index_exists?(:posts, :created_at)

    add_index :comments, :user_id unless index_exists?(:comments, :user_id)

    # Tag lookups by name are common (search by #tag)
    add_index :tags, :name unless index_exists?(:tags, :name)
  end
end
