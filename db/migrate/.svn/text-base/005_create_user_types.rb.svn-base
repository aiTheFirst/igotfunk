class CreateUserTypes < ActiveRecord::Migration
  def self.up
    create_table :user_types do |t|
      t.column :key, :string
      t.column :name, :string
      t.timestamps
    end
    
    UserType.create :key => 'ADMIN', :name => 'admin'
    UserType.create :key => 'USER',  :name => 'user'
  end

  def self.down
    drop_table :user_types
  end
end
