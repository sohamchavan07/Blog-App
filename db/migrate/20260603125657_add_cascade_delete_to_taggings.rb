class AddCascadeDeleteToTaggings < ActiveRecord::Migration[8.0]
  def up
    # Remove existing if they exist (just to be safe)
    remove_foreign_key :taggings, :posts if foreign_key_exists?(:taggings, :posts)
    remove_foreign_key :taggings, :tags if foreign_key_exists?(:taggings, :tags)
    remove_foreign_key :comments, :posts if foreign_key_exists?(:comments, :posts)
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users)
    remove_foreign_key :posts, :users if foreign_key_exists?(:posts, :users)

    add_foreign_key :taggings, :posts, on_delete: :cascade, deferrable: :deferred
    add_foreign_key :taggings, :tags, on_delete: :cascade, deferrable: :deferred
    add_foreign_key :comments, :posts, on_delete: :cascade, deferrable: :deferred
    add_foreign_key :comments, :users, on_delete: :cascade, deferrable: :deferred
    add_foreign_key :posts, :users, on_delete: :cascade, deferrable: :deferred
  end

  def down
    remove_foreign_key :taggings, :posts
    remove_foreign_key :taggings, :tags
    remove_foreign_key :comments, :posts
    remove_foreign_key :comments, :users
    remove_foreign_key :posts, :users

    add_foreign_key :taggings, :posts
    add_foreign_key :taggings, :tags
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :users
    add_foreign_key :posts, :users
  end
end
