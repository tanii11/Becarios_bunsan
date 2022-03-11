import SweetXml

defmodule MetroCdmxChallenge do
    defmodule Line do
        defstruct [:name, :stations]
    end

    defmodule Station do
        defstruct [:name, :coords]
    end

    
    def metro_line(path) do
      doc = File.read!(path)
  
      nombre_lineas =
        doc
        |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"l)
        |> Enum.map(fn l -> List.to_string(l) end)
  
        nombre_lineas |> Enum.map(fn item ->
          estaciones = doc
          |> xpath(~x"//Document/Folder[1]/Placemark[name=\"#{item}\"]/LineString/coordinates/text()"l)
          |> Enum.map(fn l -> List.to_string(l) end)
          |> List.first()
          |> String.split()
          |> Enum.map(fn coor ->
            %Station{
              name:
              doc
              |> xpath(~x"//Document/Folder[2]/Placemark[contains(./Point/coordinates,\"#{coor}\")]/name/text()"l)
              #|> List.first()
              |> List.to_string(),
              #|> IO.inspect(),
              coords: coor
            }
          end)

          #IO.inspect(item)
          #IO.inspect(estaciones)
          %Line{
            name: item,
            stations: estaciones
          }
        end)
        |> Enum.map(fn line -> %Line{name: line.name, stations: line.stations |> Enum.filter(fn station -> station.name != "" end)} end)    
    end

    def metro_graph(path) do
      lines = metro_line(path)
      graph = Graph.new(type: :undirected)
      Enum.reduce(lines, graph, fn line, graph ->
         biStation = Enum.chunk_every(line.stations, 2, 1, :discard)
         Enum.reduce(biStation, graph, fn station, graph ->
             Graph.add_edge(graph, List.first(station).name, List.last(station).name)
         end)
       end) 
    end
  
end

