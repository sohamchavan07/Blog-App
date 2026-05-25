class AddIndexToPostsStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :posts_statuses, :status, :integer
    add_index :posts_statuses, :status
  end
end
