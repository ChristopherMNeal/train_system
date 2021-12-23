require 'city'
require 'spec_helper'

describe('#City') do
  describe("#initialize") do
    it('should create new object city') do
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      expect(city1.station_name).to(eq("Union Station"))
    end
  end

  describe("#save") do
    it('should save object city to database cities') do
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      city1.save
      expect(City.all).to(eq([city1]))
    end
  end

  describe("#update") do
    it('should update train station name from King Street Station to Union Station') do
      city1 = City.new({:name => "Portland", :station_name => "King Street Station", :id => nil})
      city1.save
      city1.update("Portland", "Union Station")
      expect(City.all[0].station_name).to(eq("Union Station"))
    end
  end

  describe(".find") do
    it('should find a city by id') do
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      city1.save
      city2 = City.new({:name => "Seattle", :station_name => "King Street Station", :id => nil})
      city2.save
      expect(City.find(city1.id)).to(eq(city1))
    end
  end

  describe("#trains") do
    it('should list all trains for a city') do
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      city1.save
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      train1.save
      train2 = Train.new({:name => "Amtrak Portland-LA", :id => nil})
      train2.save
      train1.add_stop({:city_name => "Portland", :time => '12:00:00'})
      train2.add_stop({:city_name => "Portland", :time => '13:00:00'})
      expect(city1.trains).to(eq([train1, train2]))
    end
  end
end
