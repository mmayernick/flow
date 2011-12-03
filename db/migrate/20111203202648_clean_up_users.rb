class CleanUpUsers < ActiveRecord::Migration
  def up
    remove_column :users, :fullname
    remove_column :users, :crypted_password
    remove_column :users, :salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
    remove_column :users, :last_checked_at
    
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :is_approved_for_feed, :boolean, :default => false
    add_column :users, :password_digest, :string
    add_column :users, :password_reset_token, :string
    
    User.reset_column_information
    
    User.all.each do |u|
      u.is_admin = (u.admin == 1)
      u.password = UUID.new.generate(:compact)
      u.is_approved_for_feed = (u.approved_for_feed == 1)
      u.save!
    end
    
    remove_column :users, :admin
    remove_column :users, :approved_for_feed
  end

  def down
     raise ActiveRecord::IrreversibleMigration
  end
end