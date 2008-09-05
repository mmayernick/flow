class DropCategories < ActiveRecord::Migration
  def self.up
    drop_table :categories
  end

  def self.down
    create_table "categories", :force => true do |t|
      t.string   "name"
      t.string   "title"
      t.integer  "parent_id"
      t.string   "query"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
