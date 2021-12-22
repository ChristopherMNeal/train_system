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
  name = params[:]

end
