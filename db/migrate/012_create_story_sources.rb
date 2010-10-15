class CreateStorySources < ActiveRecord::Migration
  def self.up
    create_table :story_sources do |t|
      t.column :name, :string
      t.column :domain, :string
      t.column :video_player_code, :text
      t.column :parent_id, :int, :default => -1
      t.column :is_redirected, :boolean, :default => false 
      t.column :video_link, :string
      t.column :icon_filename, :string
      t.timestamps
    end
    
    # Create the source information for YouTube
    StorySource.create :name => 'YouTube', 
                       :domain => 'youtube.com', 
                       :is_redirected => true,
                       :video_link => 'http://youtube.com/watch?v=<<#VIDEO_ID#>>',
                       :video_player_code => '<object width="425" height="344"><param name="wmode" value="transparent" /><param name="movie" value="http://www.youtube.com/v/<<#VIDEO_ID#>>&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/<<#VIDEO_ID#>>&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344" wmode="transparent"></embed></object>',
                       :icon_filename => 'YouTube.jpg'
    
    # Create the source information for Metacafe
    StorySource.create :name => 'metacafe', 
                       :domain => 'metacafe.com', 
                       :is_redirected => true,
                       :video_link => 'http://www.metacafe.com/watch/<<#VIDEO_ID#>>',
                       :video_player_code => '<embed src="http://www.metacafe.com/fplayer/<<#VIDEO_ID#>>.swf" width="400" height="345" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowFullScreen="true"></embed>',
                       :icon_filename => 'MetaCafe.jpg'
                       
                                         
  end

  def self.down
    drop_table :story_sources
  end
end
