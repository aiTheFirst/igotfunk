class Status < ActiveRecord::Base
  
  # Relationships
  belongs_to :user
  
  # Validations
  validates_presence_of :description
  
  def self.find_latest_for_user(user_id)
    Status.find :first, :conditions => ['user_id = ?', user_id], :order => 'created_at DESC'
  end
end
