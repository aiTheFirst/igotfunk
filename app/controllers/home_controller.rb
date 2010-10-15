class HomeController < ApplicationController
  
  layout 'main'

  def index
    @most_viewed_stories = Story.find_most_viewed(5)
    @top_funked_stories = Story.find_top_funked(5)
  end
end
