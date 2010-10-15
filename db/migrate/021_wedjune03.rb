class Wedjune03 < ActiveRecord::Migration
  def self.up
            # Create the source information for ebaumsworld
    StorySource.create :name => 'ebaumsworld', 
                       :domain => 'ebaumsworld.com', 
                       :is_redirected => true,
                       :video_link => 'http://www.ebaumsworld.com/video/watch/<<#VIDEO_ID#>>',
                       :video_player_code => '<embed src="http://www.ebaumsworld.com/player.swf" allowScriptAccess="always" flashvars="pageurl=http://www.ebaumsworld.com/video/watch/<<#VIDEO_ID#>>/&file=http://media.ebaumsworld.com/mediaFiles/video/552301/<<#VIDEO_ID#>>.flv&mediaid=<<#VIDEO_ID#>>&title=Anderson Cooper Goes Shopping For Weed&tags=anderson,cooper,weed,legal,cnn,news,shopping,marijuana,pot&description=You Can Tell This Isn&#39;t His Normal Routine... Or Is It???&displayheight=325&backcolor=0x0d0d0d&lightoclor=0x336699&frontcolor=0xcccccc&image=http://media.ebaumsworld.com/2009/06/<<#VIDEO_ID#>>/pot.jpg&username=blackmanisgod" wmode="transparent" loop="false" menu="false" quality="high" bgcolor="#ffffff" width="425" height="345" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />',
                       :icon_filename => 'veoh.jpg'
                       
                       
      ### BEGIN ebaumsworld story source id filters ###
    
    story_source_id = StorySource.find_by_domain('ebaumsworld.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'ebaumsworld\.com\/video\/watch\/',
                               :priority => 1,
                               :pre_id_url => 'ebaumsworld.com/video/watch/'
    
    ### END ebaumsworldstory source id filters ###
  end

  def self.down
  end
end