import SweetXml

defmodule MetroCdmxChallenge do
    defmodule Line do
        defstruct [:name, :stations]
    end

    defmodule Station do
        defstruct [:name, :coords]
    end

    def metro_line() do
      doc = File.read!("./data/Metro_CDMX.kml")
  
      nombre_lineas =

        doc
        |> xpath(~x"//Document/Folder[1]/Placemark/name/text()"l)
        |> Enum.map(fn l -> List.to_string(l) end)
  
        metro =
        nombre_lineas |> Enum.map(fn item ->
          #IO.inspect(item)
          estaciones = doc
          |> xpath(~x"//Document/Folder[1]/Placemark[name=\"#{item}\"]/LineString/coordinates/text()"l)
          |> Enum.map(fn l -> List.to_string(l) end)
          |> List.first()
          |> String.split()
          #|> IO.inspect()
          |> Enum.map(fn item ->
            #IO.inspect(item)
            %Station{
              name:
              doc
              |> xpath(~x"//Document/Folder[2]/Placemark[contains(./Point/coordinates,\"#{item}\")]/name/text()"l)
              |> Enum.map(fn l -> List.to_string(l) end)
              |> List.first(),
              #|> IO.inspect(),
              coords: item
            }
          end)
          #IO.inspect(item)
          #IO.inspect(estaciones)
          %Line{
            name: item,
            stations: estaciones
          }
        end)

    end

    def metro_graph() do
      lines = metro_line()
      graph = Graph.new(type: :undirected)
      Enum.reduce(lines, graph, fn line, graph ->
         biStation = Enum.chunk_every(line.stations, 2, 1, :discard)
         Enum.reduce(biStation, graph, fn station, graph ->
             Graph.add_edge(graph, List.first(station).name, List.last(station).name)
         end)
       end) 
    end
  
end

