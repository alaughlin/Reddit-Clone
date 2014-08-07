class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title
      t.string :description

      t.timestamps
    end

    add_index(:subs, :title, unique: true)
  end
end
