require("rspec")
require("train")

describe('#Train') do
  describe("#initialize") do
    it('should create new object train') do
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      expect(train1.name).to(eq("Amtrak Portland-Seattle"))
    end
  end

  describe("#save") do
    it('should save object train to database trains') do
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      train1.save
      expect(Train.all).to(eq([train1]))
    end
  end

  # describe("#update") do
  #   it('should update train station name from Amtrak Seattle-Vancouver to Amtrak Portland-Seattle') do
  #     train1 = City.new({:name => "Amtrak Portland-Seattle", :id => nil})
  #     city1.save
  #     city1.update("Amtrak Portland-LA")
  #     expect(City.all[0].station_name).to(eq("Union Station"))
  #   end
  # end

  describe(".find") do
    it('should find a city by id') do
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      train1.save
      train2 = Train.new({:name => "Amtrak Portland-LA", :id => nil})
      train2.save
      expect(Train.find(train1.id)).to(eq(train1))
    end
  end
  
  describe("#add_stop") do
    it('should find a city by id') do
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      train1.save
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      city1.save
      train1.add_stop({:city_name => "Portland", :time => '08:00:00'})
      result = DB.exec("SELECT * FROM stops;")
      expect(result.first.fetch("time")).to(eq('08:00:00'))
    end
  end
  
  describe("#stops") do
    it('should find stops for a train') do
      train1 = Train.new({:name => "Amtrak Portland-Seattle", :id => nil})
      train1.save
      city1 = City.new({:name => "Portland", :station_name => "Union Station", :id => nil})
      city1.save
      train1.add_stop({:city_name => "Portland", :time => '08:00:00'})
      expect(train1.stops[0][:train_id]).to(eq(train1.id))
    end
  end 
end
