class DistanceGraph
  INFINITY = 1 << 64

  attr_reader :graph, :locations, :previous, :distance #getter methods
  def initialize
    @graph = {} # the graph // {location => { neighbour1 => distance, neighbour2 => distance}, location2 => ...
    @locations = Array.new
  end

# connect each location with target and distance
  def connect_graph(source, target, weight)
    if (!graph.has_key?(source))
      graph[source] = {target => weight}
    else
      graph[source][target] = weight
    end
    if (!locations.include?(source))
      locations << source
    end
  end

# connect each location bidirectional
  def add_location(source, target, weight)
    connect_graph(source, target, weight) #directional graph
    connect_graph(target, source, weight) #non directed graph (inserts the other locations too)
  end


  def dijkstra(source)
    @distance={}
    @previous={}
    locations.each do |location| #initialization
      @distance[location] = INFINITY #Unknown distance from source to each location
      @previous[location] = -1 #Previous location in optimal path from source
    end

    @distance[source] = 0 #Distance from source to source

    traversing_locations(locations.compact)
  end

  def traversing_locations(unvisited_location)
    while (unvisited_location.size > 0)
      u = nil;
      unvisited_location.each do |min|
        if (not u) or (@distance[min] and @distance[min] < @distance[u])
          u = min
        end
      end
      if (@distance[u] == INFINITY)
        break
      end
      unvisited_location = unvisited_location - [u]
      graph[u].keys.each do |location|
        alt = @distance[u] + graph[u][location]
        if (alt < @distance[location])
          @distance[location] = alt
          @previous[location] = u #A shorter path to v has been found
        end
      end
    end
  end


# To find the full shortest route to a location

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end


# Gets all shortest paths using dijkstra

  def shortest_paths(source, dest)
    @graph_paths=[]
    @source = source
    dijkstra source
    @path=[]
    find_path dest
    actual_distance=if @distance[dest] != INFINITY
                      @distance[dest]
                    else
                      "no path"
                    end
    "Shortest route and distance : #{@path.join("-->")}, #{actual_distance} km"
  end

# user inputs and outputs

  def load_locations
    add_location('Bangalore', 'Belgaum', 24)
    add_location('Bangalore', 'Mysore', 71)
    add_location('Belgam', 'Tumkur', 59)
    add_location('Mandya', 'Mangalore', 141)
    add_location('Tumkur', 'Mandya', 65.5)
    add_location('Mandya', 'Mysore', 101)
    add_location('Belgaum', 'Chickmangalur', 103)
    add_location('Mandya', 'Tumkur', 65)
    add_location('Mangalore', 'Mysore', 169)
    add_location('Mysore', 'Tumkur', 134)
  end

  def read_inputs
    puts "1:Find distance"
    puts "2:Exit"
    puts "Enter the required option :"
    begin
      i=true
      option=gets.chomp.to_i
      if option !=1 and option !=2
        i=false
        puts "Choose the correct option to proceed :"
      end
    end while (i==false)
    case option
      when 1
        get_distance
      when 2
        exit
    end
  end

  def get_distance
    puts "Available locations are :"
    puts locations
    puts "======================"
    puts "Enter city#1 :"
    city1=read_city
    puts "Enter city#2 :"
    city2=read_city
    graph_path=shortest_paths(city1, city2)
    puts "======================"
    puts graph_path
    puts "======================"
    read_inputs
  end

  def read_city
    begin
      i=true
      city=gets.chomp
      if !locations.include? city
        i=false
        puts "Enter valid city :"
      end
    end while (i==false)
    city
  end
end


