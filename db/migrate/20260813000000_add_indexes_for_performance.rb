class AddIndexesForPerformance < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, :user_id
    add_index :posts, :slug, unique: true
    add_index :posts, :created_at

    add_index :comments, :user_id

    # Tag lookups by name are common (search by #tag)
    add_index :tags, :name
  end
end
