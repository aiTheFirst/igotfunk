module StoriesHelper
  def thumbnail_link(story)
    story.story_source.thumbnail_link ? story.story_source.thumbnail_link.gsub("<<#VIDEO_ID#>>",story.url_video_id.split("/")[0]) : "/images/defaultpreview.jpg"
  end
   
  
end
