class ChartController < ApplicationController
  def index
    unless params[:chart_type] == nil || params[:limit] == nil
      if params[:chart_type] == 'mostfunked'
        @stories = Story.find_most_funked(params[:limit])
        @chart_type = "MOST_FUNKED"
      elsif params[:chart_type] == 'mostviewed'
        @stories = Story.find_most_viewed(params[:limit])
        @chart_type = "MOST_VIEWED"
      end
      
      render :partial => 'home/top20', 
             :locals => { :stories => @stories, 
                          :chart_type => @chart_type }
    end
  end
end
