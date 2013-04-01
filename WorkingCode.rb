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
  attr_accessor :trip_route
  attr_accessor :line
  attr_accessor :no_lines_in_trip

  # def find_no_intersection  # returns number of intersections
    
  #     case 
  #       line.include? (@start_point) && line.include? (@start_point)
  #     when
  # end

  # def determine_line
    
  #   if @start_point == @end_point
  #     puts "You are already here silly goose!"
  #     return
  #   end

  #   case @start_point
  #   when condition
      
  #     # route_line = SUBWAY[:line]
  # end

  def generate_route_single_line (route_line)
    s = route_line.index (@start_point)
    e = route_line.index (@end_point)
    # binding.pry
    if s < e
      @trip_route = route_line[s..e]
    else
      @trip_route = route_line[e..s].reverse
    end
    # binding.pry
  end

  def generate_route_two_lines
    
  end

end


puts "Welcome to MTA TripCalc by Oren"
puts "!!Please note that for now we assume Union Square in the only intersection!!"
my_trip = Route.new
my_trip.get_start_end_points
my_trip.generate_route_single_line(SUBWAY["6 line"])
# binding.pry
puts my_trip.trip_route

# we assume Union Square is the only intersection between the lines


