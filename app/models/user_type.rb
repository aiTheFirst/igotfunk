# A User Type is determines what priviledges a user has
class UserType < ActiveRecord::Base
  
  # Many users can have a user type
  has_many :users
  
end
