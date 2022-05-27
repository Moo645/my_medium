class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true
      t.text :content
      t.datetime :delete_at

      t.timestamps
    end
    add_index :comments, :delete_at
  end
end
