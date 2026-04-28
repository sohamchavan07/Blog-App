class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  def change
    # Already present in many setups; kept for idempotency with if_not_exists.
    add_index :users, :email, unique: true, if_not_exists: true

    # Improves ordering/filtering posts by recency.
    add_index :posts, :created_at, if_not_exists: true

    # Used for tag lookups from "#tag" searches.
    add_index :tags, :name, unique: true, if_not_exists: true

    # Speeds post-tag joins and prevents duplicate taggings.
    add_index :taggings, [ :post_id, :tag_id ], unique: true, if_not_exists: true
  end
end
