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

  	  
    if @start_line == @end_line # if traveling on a single line    
  	  
      # to avoid conflict if start or end at Union Square
      if start_point == "Union Square" 
        line_to_use = @start_line
      else
        line_to_use = @end_line
      end    
      
      generate_route_single_line(line_to_use[1])	

    else
      genrate_route_two_lines
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
    @number_of_stops = trip_route.length - 1
    puts "Total number of stops (not including the start): #{@number_of_stops}"
  end


  # assumes intersection at Union Square
  def genrate_route_two_lines

    start_line_name = @start_line[0]
    start_line_stations = @start_line[1]

    end_line_name = @end_line[0]
    end_line_stations = @end_line[1]

    # slice the unused stations for start_line
    i = start_line_stations.index("Union Square")
    e = start_line_stations.index(@start_point)
    if i < e
      start_line_stations = start_line_stations[i..e].reverse
    else
      start_line_stations = start_line_stations[e..i]
    end

    # slice the unused stations for start_line
    i = end_line_stations.index("Union Square")
    e = end_line_stations.index(@end_point)
    if i < e
      end_line_stations = end_line_stations[i..e]
    else
      end_line_stations = end_line_stations[e..i].reverse
    end

    puts "----------"
    puts "take the #{start_line_name} to Union Square"
    puts "change at Union Square to #{end_line_name}"
    puts "----------"
    puts "Your Route is:"
    puts start_line_stations.join " --> "
    puts "change at Union Square"
    puts end_line_stations.join " --> "

    # take out the intersections
    start_line_stations.pop
    end_line_stations.shift
    puts "----------"
    @number_of_stops = start_line_stations.length +  start_line_stations.length
    puts "Total number of stops (not including the start): #{@number_of_stops}"
    puts "----------"
  end

end


puts "Welcome to MTA TripCalc by Oren"
puts "!!Please note that for now we assume Union Square in the only intersection!!"
trip = Route.new




