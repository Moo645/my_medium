class AddDeletedAtToStory < ActiveRecord::Migration[6.1]
  def change
    add_column :stories, :deleted_at, :datetime
    add_index :stories, :deleted_at
    #Ex:- add_index("admin_users", "username")
  end
end
