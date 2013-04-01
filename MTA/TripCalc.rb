require 'pry'
# require 'test/unit'
require_relative 'SubwayMap'

class Trip
  
  attr_accessor :start_point
  attr_accessor :end_point


  #validates that a station exists in the subway, if not asks user and returns a validated station
  def validate_station(station)
    
    unless ALLSTATIONS.include? (station) #if it is a valid station, finish validation
      loop do  #runs only if it is not a valid station
        puts "please enter a valid station (l to list stations):"
        station = gets.strip
        if station == "l"  #displays list of the stations if user chose l
          puts "Available stations in the subway: "
          puts "!!Note that some station names include the line!!"  #because program supports only single intesection
          puts ALLSTATIONS.join ", "  
        end
        break if ALLSTATIONS.include? (station)
      end 
    end
  
  return station  #returns a validated station
  end

  #gets the start and end points form the user
  def get_start_end_points
    print "where are you starting?"
    @start_point = gets.strip
    @start_point = validate_station(@start_point)

    print "where would you like to go?"
    @end_point = gets.strip
    @end_point = validate_station(@end_point)
  end

end

# generates the route
class Route < Trip
  attr_accessor :start_line         #array with name and [stations]
  attr_accessor :end_line           #array with name and [stations]
  attr_accessor :number_of_stops    # not including start point

  def initialize	
    get_start_end_points

    # check if user already here
    if @start_point == @end_point    
      puts "You are already here silly goose :-)"
    return
    end

  	# determines the lines and puts them into the @start_line and @end_line
    lines_used

  	  # if traveling on a single line
      if @start_line == @end_line     
  	generate_route_single_line(@start_line[1])	
  	end

    puts "Thank you for traveling with Oren's TripCale"
  end

  def lines_used  
    SUBWAY.each do |key, value|  # creates the start and end lines
    	if value.include?(@start_point) 
    	  @start_line = [key, value]
    	end

    	if value.include?(@end_point) 
    	  @end_line = [key, value]
    	end
    end
  end

  def generate_route_single_line (route_line)
    s = route_line.index (@start_point)
    e = route_line.index (@end_point)
    if s < e
      trip_route = route_line[s..e]
    else
      trip_route = route_line[e..s].reverse
    end

    puts "You don't need to change lines"
    puts "Your route is: #{trip_route.join " -> "}"
    binding.pry
    @number_of_stops = trip_route.length - 1
    puts "Total number of stops (not including the start): #{@number_of_stops}"
  end

end


puts "Welcome to MTA TripCalc by Oren"
puts "!!Please note that for now we assume Union Square in the only intersection!!"
trip = Route.new




