class CreateStorySourceIdFilters < ActiveRecord::Migration
  def self.up
    create_table :story_source_id_filters do |t|
      t.column :story_source_id, :int
      t.column :priority, :int, :default => 0
      t.column :pre_id_regex, :string
      t.column :post_id_regex, :string, :default => '&'
      t.column :pre_id_url, :string
      t.column :post_id_url, :string, :default => '&'
      t.timestamps
    end
    
    ### BEGIN YouTube story source id filters ###
    
    story_source_id = StorySource.find_by_domain('youtube.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'youtube\.com\/watch\?v=',
                               :priority => 1,
                               :pre_id_url => 'youtube.com/watch?v='
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => '[a-z][a-z].youtube\.com\/watch\?v=',
                               :priority => 2,
                               :pre_id_url => 'youtube.com/watch?v='
    
    StorySourceIdFilter.create :story_source_id => story_source_id,
                               :pre_id_regex => 'youtube\.com\/v\/', 
                               :priority => 3,
                               :pre_id_url => 'youtube.com/v/'
    
    ### END YouTube story source id filters ###
    
    ### BEGIN metacafe story source id filters ###
    
    story_source_id = StorySource.find_by_domain('metacafe.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'metacafe\.com\/watch\/',
                               :priority => 1,
                               :pre_id_url => 'metacafe.com/watch/'
    
    ### END metacafe story source id filters ###
    
  end

  def self.down
    drop_table :story_source_id_filters
  end
end
