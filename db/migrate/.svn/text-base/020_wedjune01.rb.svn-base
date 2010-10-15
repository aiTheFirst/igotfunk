class Wedjune01 < ActiveRecord::Migration
  def self.up
            # Create the source information for dailymotion
    StorySource.create :name => 'dailymotion', 
                       :domain => 'dailymotion.com', 
                       :is_redirected => true,
                       :video_link => 'http://www.dailymotion.com/video/<<#VIDEO_ID#>>',
                       :video_player_code => '<div><object width="480" height="381"><param name="movie" value="http://www.dailymotion.com/swf/<<#VIDEO_ID#>>&related=1"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><embed src="http://www.dailymotion.com/swf/<<#VIDEO_ID#>>&related=1" type="application/x-shockwave-flash" width="480" height="381" allowFullScreen="true" allowScriptAccess="always"></embed></object></div>',
                       :icon_filename => 'veoh.jpg'
                       
                       
      ### BEGIN dailymotion story source id filters ###
    
    story_source_id = StorySource.find_by_domain('dailymotion.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'dailymotion\.com\/video\/',
                               :priority => 1,
                               :pre_id_url => 'dailymotion.com/video/'
    
    ### END dailymotion story source id filters ###
  end

  def self.down
  end
end
