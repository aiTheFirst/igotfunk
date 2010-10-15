class UserProfile < ActiveRecord::Base
  # Every profile is associated with one user
  belongs_to :user
end
