# DON'T CHANGE THIS CODE
# ----------------------
require "net/http"
require "json"
url = "https://weatherdbi.herokuapp.com/data/weather/chicago"
uri = URI(url)
response = Net::HTTP.get(uri)
weather_data = JSON.parse(response)
# ----------------------

# EXERCISE
# Using the Ruby hash `weather_data` that includes weather forecast data for Chicago,
# write a weather summary out to the screen including the current conditions and upcoming forecast.
# Something like the output below.

# Sample output:
# In Chicago, IL it is currently 67 degrees and cloudy.
# The rest of today will be a high of 65 and scattered shows.
# The upcomming weather forecast is:
# Wednesday: a high of 65 and scattered showers.
# Thursday: a high of 67 and partly cloudy.
# Friday: a high of 59 and rain.
# Saturday: a high of 77 and cloudy.
# ...

# STEPS
# Look at the weather_data hash.
# Find the current data.
# Build a string with the text and dynamic data from the hash.
# "In #{...} it is currently #{...} degrees and #{...}"
# Find the array of forecast data.
# Read only the first element of that array to display the conditions for the rest of today.
# Use a loop to display the daily summary for the upcoming forecast.

# 1. inspect the weather_data hash
puts "In #{weather_data["region"]} it is currently #{weather_data["currentConditions"]["temp"]["f"]} degrees and #{weather_data["currentConditions"]["comment"].downcase}."
puts "The rest of today will be a high of #{weather_data["next_days"][0]["max_temp"]["f"]} and #{weather_data["next_days"][0]["comment"].downcase}."
puts "The upcoming weather forecast is:"
index = 1
loop do
    if index == weather_data["next_days"].size
        break
    else     
        puts "#{weather_data["next_days"][index]["day"]}: a high of #{weather_data["next_days"][index]["max_temp"]["f"]} and #{weather_data["next_days"][index]["comment"].downcase}."
    index = index + 1
    end
end

# CHALLENGE
# Can you display the weather forecast summary for a user-entered city?
# Use the following code at the very top of the file and then replace "chicago" in the api url with the user-entered city:

# Ask the user what city they are in
puts "What city are you in?"
# Store the input and remove whitespace to make compatible with browser
city = gets.chomp.gsub(/\s+/, "")

# Construct a URL and access the API
url = "https://weatherdbi.herokuapp.com/data/weather/#{city.downcase}"
uri = URI(url)
response = Net::HTTP.get(uri)
weather_data_user = JSON.parse(response)

# Print the result with error handling
if weather_data_user["status"] == "fail" then
    puts "Sorry, that city is not recognized. Please try again"
else
    puts "In #{weather_data_user["region"]} it is currently #{weather_data_user["currentConditions"]["temp"]["f"]} degrees and #{weather_data_user["currentConditions"]["comment"].downcase}."
    puts "The rest of today will be a high of #{weather_data_user["next_days"][0]["max_temp"]["f"]} and #{weather_data_user["next_days"][0]["comment"].downcase}."
    puts "The upcoming weather forecast is:"
    index = 1
    loop do
        if index == weather_data_user["next_days"].size
            break
        else     
            puts "#{weather_data_user["next_days"][index]["day"]}: a high of #{weather_data_user["next_days"][index]["max_temp"]["f"]} and #{weather_data_user["next_days"][index]["comment"].downcase}."
        index = index + 1
        end
    end
end