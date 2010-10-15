class AddNewSourceid < ActiveRecord::Migration
  def self.up
        ### BEGIN VIMEO story source id filters ###
    
    story_source_id = StorySource.find_by_domain('vimeo.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'vimeo\.com\/',
                               :priority => 1,
                               :pre_id_url => 'vimeo.com/'
    
    ### END VIMEO story source id filters ###
    
        # BEGIN myspace story source id filters ###
    
        story_source_id = StorySource.find_by_domain('myspace.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'vids\.myspace\.com\/index\.cfm\?fuseaction=vids\.individual&videoid=',
                               :priority => 1,
                               :pre_id_url => 'vids.myspace.com/index.cfm?fuseaction=vids.individual&videoid='
    ### END myspace story source id filters ###
    
        # BEGIN tangle story source id filters ###
    
    story_source_id = StorySource.find_by_domain('tangle.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'tangle\.com\/view_video\.php\?viewkey=',
                               :priority => 1,
                               :pre_id_url => 'tangle.com/view_video.php?viewkey='
                               
    ### END tangle story source id filters ###
    
    
      ### BEGIN cnn story source id filters ###
    
    story_source_id = StorySource.find_by_domain('cnn.com').id
    
    StorySourceIdFilter.create :story_source_id => story_source_id, 
                               :pre_id_regex => 'cnn\.com\/video\/#',
                               :priority => 1,
                               :pre_id_url => 'cnn.com/video/#'
    
   ### END cnn story source id filters ###
    

  end

  def self.down
  end
end
