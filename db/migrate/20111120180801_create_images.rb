class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :item_id
      t.string :image_content_type
      t.string :image_file_name
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
    add_index :images, :item_id
  end
end