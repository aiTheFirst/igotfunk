class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.column :user_id, :int
      t.column :location, :string
      t.column :website, :string
      t.column :views, :int, :default => 0
      t.column :gender, :string
      t.column :birthday, :date
      t.timestamps
    end
    
    @users = User.find :all
    for user in @users
      if user.user_profile == nil
        UserProfile.create :user_id => user.id
      end
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
