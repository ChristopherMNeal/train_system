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

get('/cities/:id') do
  @city = City.find(params[:id].to_i)
  erb(:city)
end

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i)
  erb(:edit_city)
end

patch('/cities/:id') do
  @city = City.find(params[:id].to_i)
  city = params[:city_name]
  station = params[:station_name]
  @city.update(city, station)
  redirect to('/cities')
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i)
  @city.delete
  redirect to('/cities')
end

get('/trains/:id') do
  @trains = Train.all
  @cities = City.all
  @train = Train.find(params[:id].to_i)
  @stops = @train.stops
  erb(:train)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i)
  erb(:edit_train)
end

patch('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.update({:name => params[:train_name]})
  redirect to('/trains')
end

delete('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.delete
  redirect to('/trains')
end

post('/stops/:id') do
  @train = Train.find(params[:id].to_i)
  psql_time = params[:time] + ':00'
  city_name = params[:city_name]
  @train.add_stop({:city_name => city_name, :time => psql_time})
  @stops = @train.stops
  @cities = City.all
  erb(:train)
end

delete('/stops/:id/:stop_id') do
  @train = Train.find(params[:id].to_i)
  @train.delete_stop(params[:stop_id])
  @cities = City.all
  @trains = Train.all
  @stops = @train.stops
  erb(:train)
end

get('/stops') do
  @trains = Train.all
  erb(:stops)
end

get('/tickets') do
  @cities = City.all
  erb(:tickets)
end

post('/tickets') do
  @cities = City.all
  @city_selected = params[:city_id].to_i
  @city = City.find(@city_selected)
  @trains = @city.trains
  erb(:tickets)
end

post('/tickets/:id') do
  @city_selected = params[:id].to_i
  @train_id = params[:train_id].to_i
  @train = Train.find(@train_id)
  @city = City.find(@city_selected)
  @cities = City.all
  @trains = Train.all
  erb(:tickets)
end