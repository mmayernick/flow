class AddIndexes < ActiveRecord::Migration
  def up
    add_index :comments, :item_id
    add_index :comments, :user_id
    
    add_index :items, :user_id
    add_index :items, :title
    add_index :items, :name
    add_index :items, :url
    
    add_index :users, :login
  end

  def down
    remove_index :comments, :column => :item_id
    remove_index :comments, :column => :user_id
    
    remove_index :items, :column => :user_id
    remove_index :items, :column => :title
    remove_index :items, :column => :name
    remove_index :items, :column => :url
    
    remove_index :users, :column => :login
  end
end