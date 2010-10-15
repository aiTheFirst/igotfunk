class StoryComment < ActiveRecord::Base
  
  # Relationships
  belongs_to :user
  belongs_to :story
  
  # Validations
  validates_presence_of :description
  
end
