class AddIndexToPostsStatus < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, :status
  end
end
