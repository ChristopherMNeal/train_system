require('pry')

class City
  attr_accessor :id,:name, :station_name
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @station_name = attributes.fetch(:station_name)
    @id = attributes.fetch(:id)
  end
  
  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      station_name = city.fetch("station_name")
      id = city.fetch("id").to_i
      cities.push(City.new({:name => name, :station_name => station_name, :id => id}))
    end
    cities
  end
  
  def save
    result = DB.exec("INSERT INTO cities (name, station_name) VALUES ('#{@name}', '#{@station_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(city_to_compare)
    (self.name == city_to_compare.name) && (self.station_name == city_to_compare.station_name)
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end
  
  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    name = city.fetch("name")
    station_name = city.fetch("station_name")
    id = city.fetch("id")
    City.new({:name => name, :station_name => station_name, :id => id})
  end

  def update(name, station_name)
    @name = name
    @station_name = station_name
    DB.exec("UPDATE cities SET name = '#{@name}', station_name = '#{@station_name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end
  
  def trains
    trains = []
    results = DB.exec("SELECT * FROM stops WHERE city_id = #{@id};")
    # stops train id city id stop id time
    results.each do |stop| 
      train_id = stop.fetch("train_id")
      train_results = DB.exec("SELECT * FROM trains WHERE id = #{train_id};").first 
      train_name = train_results.fetch("name") 
      trains.push(Train.new({:id => train_id, :name => train_name}))
    end
    trains
  end
end