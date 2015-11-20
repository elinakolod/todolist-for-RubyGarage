# Load the Rails application.
require File.expand_path('../application', __FILE__)
Date::DATE_FORMATS[:default] = "%d-%m-%Y"
# Initialize the Rails application.
Rails.application.initialize!
