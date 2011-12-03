class RemoveStars < ActiveRecord::Migration
  def up
    remove_column :items, :stars_count
    drop_table :stars
  end

  def down
    add_column :items, :stars_count, :integer, :null => false, :default => 0
    create_table :stars, :force => true do |t|
      t.integer :user_id
      t.integer :item_id
      t.timestamps
    end
  end
end