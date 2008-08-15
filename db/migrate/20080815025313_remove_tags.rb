class RemoveTags < ActiveRecord::Migration
  def self.up
    remove_column :items, :tags
  end

  def self.down
  end
end
