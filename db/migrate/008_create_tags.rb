class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string, :limit => 200
      t.column :parent_id, :int, :default => -1
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
