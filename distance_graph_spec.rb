require './distance_graph.rb' #require ruby file where the algorithm written
describe "DistanceGraph" do
  let(:new_graph) {
    DistanceGraph.new
  }
  context "graph creation" do
    it 'should initialize empty graph' do
      graph=new_graph
      expect(graph.graph).to eq({})
    end

    it 'should initialize empty locations' do
      graph=new_graph
      expect(graph.locations).to eq([])
    end

    it 'is connect graph with source,target,weight #connect_graph' do
      graph=new_graph
      graph.connect_graph("Bangalore", "Mysore", 71)
      expect(graph.graph).to eq({"Bangalore" => {"Mysore" => 71}})
    end

    it 'is connect location with source,target,weight #connect_graph' do
      graph=new_graph
      graph.connect_graph("Bangalore", "Mysore", 71)
      expect(graph.locations).to include("Bangalore")
    end

    it 'is graph connect  bidirectional #add_location' do
      graph=new_graph
      graph.add_location("Bangalore", "Mysore", 71)
      expect(graph.graph.keys).to eq(["Bangalore", "Mysore"])
    end
  end

  context "Dijkstra's_algorithm" do
    it 'is dijkstras algorithm works to track distance #dijkstra' do
      graph=new_graph
      graph.add_location("a", "b", 5)
      graph.add_location("b", "c", 3)
      graph.add_location("c", "d", 1)
      graph.dijkstra("a")
      expect(graph.distance).to eq({"a"=>0, "b"=>5, "c"=>8, "d"=>9})
    end

    it 'is dijkstras algorithm works to track connected node #dijkstra' do
      graph=new_graph
      graph.add_location("a", "b", 5)
      graph.add_location("b", "c", 3)
      graph.add_location("c", "d", 1)
      graph.dijkstra("a")
      expect(graph.previous).to eq({"a"=>-1, "b"=>"a", "c"=>"b", "d"=>"c"})
    end

    it 'is dijkstra algorithm find shortest path #shortest_paths' do
      graph=new_graph
      graph.add_location("a", "b", 5)
      graph.add_location("b", "c", 3)
      graph.add_location("c", "d", 1)
      expect(graph.shortest_paths("a","c")).to include ('Shortest route and distance : a-->b-->c, 8 km')
    end


  end


end