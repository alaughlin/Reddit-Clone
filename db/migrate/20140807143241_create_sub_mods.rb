class CreateSubMods < ActiveRecord::Migration
  def change
    create_table :sub_mods do |t|
      t.integer :user_id
      t.integer :sub_id

      t.timestamps
    end

    add_index :sub_mods, [:user_id, :sub_id], unique: true
    add_index :sub_mods, :user_id
    add_index :sub_mods, :sub_id
  end
end
