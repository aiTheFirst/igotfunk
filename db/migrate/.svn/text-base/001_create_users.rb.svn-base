class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :user_type_id,              :int
    end
    
    User.create :login => 'admin',
                :email => 'admin@atlanticcharters.ca',
                :crypted_password => 'd4c0249abca7179ebe9ff3cc1aec7289536f83f4',
                :salt => 'aff2b9c8bcbb875e197eddb295e2867864fe61c9'
  end

  def self.down
    drop_table "users"
  end
end
