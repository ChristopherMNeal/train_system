require("pry")

class Train
  attr_accessor :id, :name
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
  
  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end
  
  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(train_to_compare)
    self.name == train_to_compare.name
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end
  
  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id")
    Train.new({:name => name, :id => id})
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end
  
  def add_stop(attributes)
    city_name = attributes.fetch(:city_name)
    time = attributes.fetch(:time)
    city_id = DB.exec("SELECT id FROM cities WHERE name = '#{city_name}';").first
    if city_id != nil
      DB.exec("INSERT INTO stops (train_id, city_id, time) VALUES (#{@id}, #{city_id["id"].to_i}, '#{time}');") 
    end
  end

  def stops
    stops = []
    results = DB.exec("SELECT * FROM stops where train_id = #{@id};")
    results.each do |stop|
      city_id = stop.fetch("city_id")
      time = stop.fetch("time")
      stop_id = stop.fetch("id")
      city_info = DB.exec("SELECT * FROM cities WHERE id = #{city_id};").first
      city_name = city_info.fetch("name")
      station_name = city_info.fetch("station_name")
      stops.push({:id => stop_id, :time => time, :train_id => @id, :city_id => city_id, :city_name => city_name, :station_name => station_name }) 
    end
    stops
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE train_id = #{@id};")
  end
end
