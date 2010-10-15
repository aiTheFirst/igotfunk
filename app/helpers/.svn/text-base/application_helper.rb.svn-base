# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def calculate_age(birthday)
    (Date.today - birthday).to_i / 365
  end
  
  def calculate_time_since(start_datetime)
    (DateTime.now - start_datetime).to_i
  end
end
