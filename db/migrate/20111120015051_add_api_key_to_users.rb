class AddApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_key, :string
    add_index :users, :api_key, :unique => true
    
    User.reset_column_information
    
    User.all.each do |u|
      u.save!
    end
  end
end