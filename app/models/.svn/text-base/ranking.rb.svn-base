class Ranking < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :story
  
  def self.find_average_for_story(story_id)
    Ranking.average(:score, :conditions => ['story_id = ?', story_id])
  end
  
  def self.find_by_story_and_user(story_id, user_id)
    Ranking.find(:first, :conditions => ['story_id = ? and user_id = ?', story_id, user_id])
  end
end
