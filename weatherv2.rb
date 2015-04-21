require 'sinatra'
require 'httparty'



def returnWeather(zipcode)
  @zipcode = params['zipcode']
  @url_zipcode = "http://api.zippopotam.us/us/#{@zipcode}"

  pull_lat_long = HTTParty.get(@url_zipcode)
  parse1 = pull_lat_long.parsed_response
  parse2 = pull_lat_long.parsed_response
  parse3 = pull_lat_long.parsed_response
  @lat = parse1['places'][0]['latitude']
  @long = parse2['places'][0]['longitude']
  @city = parse3['places'][0]['place name']
  apiKey = "69340038344f74f72655d61fdd7b33da"
  @url = "https://api.forecast.io/forecast/apiKey/#{@lat},#{@long}"
  response = HTTParty.get(@url)
  @city_weather = response.parsed_response
  @current_temp = @city_weather['currently']['temperature']

  #####-- MAX AND MIN TEMPS - CODE #######################
  @tempMin = response.parsed_response
  @tempMax = response.parsed_response
  @minTemp = @tempMin['daily']['data']
  @maxTemp = @tempMax['daily']['data']
  ###################################
  @varx = []
  @minTemp.each do |n|
    @varx = n['temperatureMin']
  end
  @tempx = @varx
  #puts "#{varx} the lowest temp\n"

  ###################################
  @vary=[]
  @maxTemp.each do |n|
    @vary = n['temperatureMax']
  end
  @tempy = @vary
end


get '/' do
  erb :inputzip
end

post '/display' do
  returnWeather(@zipcode)
  erb :display
end
