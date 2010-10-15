class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.column :user_id, :int 
      t.column :description, :string, :limit => 200
      t.column :is_current, :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
