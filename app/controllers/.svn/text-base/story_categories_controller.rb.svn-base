# Controller for viewing stories by category
class StoryCategoriesController < ApplicationController
  
  layout 'main'
  
  # Generates the information to display a list of videos associated with a specific category
  def index
    if (@category = StoryCategory.find_by_slug(params[:story_category_slug])) != nil
      @stories = Story.find_for_category_page(@category.id, 1, 5)
    else
      # Set an error message because the category was invalid
      flash[:notice] = "The URL you entered is invalid."
      redirect_to home_path
    end
  end
end
