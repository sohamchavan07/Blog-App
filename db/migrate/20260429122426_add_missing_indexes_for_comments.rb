class AddMissingIndexesForComments < ActiveRecord::Migration[8.0]
  def change
    add_index :comments, :created_at, if_not_exists: true
  end
end
