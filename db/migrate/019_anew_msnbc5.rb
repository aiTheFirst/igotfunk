class AnewMsnbc5 < ActiveRecord::Migration
  def self.up
             # Create the source information for msnbc
    StorySource.create :name => 'msnbc', 
                       :domain => 'msn.com', 
                       :is_redirected => true,
                       :video_link => 'http://www.msnbc.msn.com/id/21134540/vp/<<#VIDEO_ID#>>',
                       :video_player_code => '<div><iframe height="339" width="425" src="http://www.msnbc.msn.com/id/22425001/vp/<<#VIDEO_ID#>>" frameborder="0" scrolling="no"></iframe></div>',
                       :icon_filename => 'facebook.jpg'


      ### BEGIN msnbc story source id filters ###
    
    story_source_id = StorySource.find_by_domain('msn.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'msnbc\.msn\.com\/id\/21134540\/vp\/',
                               :priority => 1,
                               :pre_id_url => 'msnbc.msn.com/id/21134540/vp/'
    
   ### END msnbc story source id filters ###
  end

  def self.down
  end
end
