class RemoveTags < ActiveRecord::Migration
  def self.up
    remove_column :items, :tags
  end

  def self.down
    add_column :items, :tags, :text, :limit => 255
  end
end
