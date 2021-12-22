require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pry')
also_reload('lib/**/*.rb')
require 'pg'

DB = PG.connect({:dbname => "train_system"})

get('/') do
  erb(:index)
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  train = Train.new({:name => "#{name}", :id => nil})
  train.save
  @trains = Train.all
  erb(:trains)
end

get('/cities/new') do
  erb(:new_city)
end

post('/cities') do
  name = params[:city_name]
  station = params[:station_name]
  city = City.new({:name => name, :station_name => station, :id => nil})
  city.save
  @cities = City.all
  erb(:cities)
end