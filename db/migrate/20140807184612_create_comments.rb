class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :post_id
      t.integer :parent_comment_id
      t.references :commentable, polymorphic: true

      t.timestamps
    end

    add_index(:comments, :post_id)
    add_index(:comments, :user_id)
  end
end
