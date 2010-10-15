class AddNewSources < ActiveRecord::Migration
  def self.up
    
     # Create the source information for Vimeo
    StorySource.create :name => 'Vimeo', 
                       :domain => 'vimeo.com', 
                       :is_redirected => true,
                       :video_link => 'http://vimeo.com/<<#VIDEO_ID#>>',
                       :video_player_code => '<object width="400" height="225"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=<<#VIDEO_ID#>>&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=<<#VIDEO_ID#>>&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="225"></embed></object>',
                       :icon_filename => 'vimeo.jpg'


    # Create the source information for myspace
    StorySource.create :name => 'myspace', 
                       :domain => 'myspace.com', 
                       :is_redirected => true,
                       :video_link => 'http://vids.myspace.com/index.cfm?fuseaction=vids.individual&videoid=<<#VIDEO_ID#>>',
                       :video_player_code => '<object width="425px" height="360px"><param name="allowFullScreen" value="true"/><param name="wmode" value="transparent"/><param name="movie" value="http://mediaservices.myspace.com/services/media/embed.aspx/m=<<#VIDEO_ID#>>,t=1,mt=video"/><embed src="http://mediaservices.myspace.com/services/media/embed.aspx/m=<<#VIDEO_ID#>>,t=1,mt=video" width="425" height="360" allowFullScreen="true" type="application/x-shockwave-flash" wmode="transparent"></embed></object>',

                       :icon_filename => 'MySpace.gif'
                       
    # Create the source information for tangle
    StorySource.create :name => 'tangle', 
                       :domain => 'tangle.com', 
                       :is_redirected => true,
                       :video_link => 'http://tangle.com/view_video.php?viewkey=<<#VIDEO_ID#>>',
                       :video_player_code => '<embed src="http://www.tangle.com/flash/swf/flvplayer.swf" FlashVars="viewkey=<<#VIDEO_ID#>>" wmode="transparent" quality="high" width="330" height="270" name="tangle" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"/></embed>',
                       :icon_filename => 'MetaCafe.jpg'
 
 
     # Create the source information for cnn
    StorySource.create :name => 'cnn', 
                       :domain => 'cnn.com', 
                       :is_redirected => true,
                       :video_link => 'http://cnn.com/video/#<<#VIDEO_ID#>>',
                       :video_player_code => '<script src="http://i.cdn.turner.com/cnn/.element/js/2.0/video/evp/module.js?loc=dom&vid=<<#VIDEO_ID#>>" type="text/javascript"></script>',
                       :icon_filename => 'CnnTiny.jpg'
                           

  
  end

  def self.down
  end
end
