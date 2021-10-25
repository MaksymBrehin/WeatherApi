class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @params = {
      :access_key => "66a4d5074f1a5c21e6ad17c4c7b7d99b",
      :query => params[:query]
    }
    if @params[:query].nil?
      @city = 'Введіть місто'
      @temperature = '(на англ.мові: Lviv, Las Vegas...)'
    else
      @uri = URI("http://api.weatherstack.com/current?access_key=66a4d5074f1a5c21e6ad17c4c7b7d99b&query=#{@params[:query]}")
      @uri.query = URI.encode_www_form(@params)
      @json = Net::HTTP.get(@uri)
      @api_response = JSON.parse(@json)
      if @api_response['location'].present?
        @city = "#{@api_response['location']['name']}"
        @temperature = "#{@api_response['current']['temperature']}°"
      else
        @city = 'Нема такого міста'
        @temperature = ''
      end
    end
  end
end


