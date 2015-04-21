require 'httparty'

#zipcode input for commandline testing. Will use for form variable
puts "please enter a zipcode:"
zipcode = gets.chomp

#concatenates the string at the end of the API
url_zipcode = "http://api.zippopotam.us/us/#{zipcode}"
# - first part is to take the zipcode parse it into lat,long - hardcoded for
#testing purposes only.
#pull_lat_long = HTTParty.get('http://api.zippopotam.us/us/91506')

#output the zipcode to confirm zipcode and also to create the pull_lat_long
#hash from the JSON of forecast.io
puts "#{zipcode} you entered\n"
pull_lat_long = HTTParty.get(url_zipcode)

#Invidual variables, refactor if possible using loop and parsing lat/long/city
parse1 = pull_lat_long.parsed_response
parse2 = pull_lat_long.parsed_response
parse3 = pull_lat_long.parsed_response
lat = parse1['places'][0]['latitude']
long = parse2['places'][0]['longitude']
city = parse3['places'][0]['place name']

#testing purposes
puts "#{lat} - the lat"
puts "#{long} - the long"
puts "#{city} - the city entered"

#lat/long passing to the forecast.io API
url = "https://api.forecast.io/forecast/69340038344f74f72655d61fdd7b33da/#{lat},#{long}"

#testing purposes
puts "#{url} being passed to forecast.io"

#finding the current temp
response = HTTParty.get(url)
city_weather = response.parsed_response
#---added this 04.20.15
current_temp = city_weather['currently']['temperature']
#---added this 04.20.15
tempMin = response.parsed_response
tempMax = response.parsed_response
minTemp = tempMin['daily']['data']
maxTemp = tempMax['daily']['data']
###################################
varx = []
minTemp.each do |n|
  varx = n['temperatureMin']
end
puts "#{varx} the lowest temp\n"

###################################
vary=[]
maxTemp.each do |n|
  vary = n['temperatureMax']
end
puts "#{vary} the high temp\n"
###################################

puts "#{current_temp} F - the current temperature.\n"
#puts minTemp.to_s +  "min temp\n"
#puts "#{minTemp} - min temp\n"
#puts "#{maxTemp} - max temp\n"
#logic to determine shorts or pants
  if current_temp >= 74.9
    puts "It's a shorts day!!"
  else
    puts "Nope to cold.. puts on some pants!"
  end
