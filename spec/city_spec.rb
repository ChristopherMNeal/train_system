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
end
