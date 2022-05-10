defmodule MetroCdmxChallenge do
  @moduledoc """
  The following program consists of relating the lines of the city of Mexico
  with their respective stations, as well as obtaining a graph with the Graph function
  """
  import SweetXml

    defmodule Line do
      @moduledoc """
      struct of the line
      """
        defstruct [:name, :stations]
    end

    defmodule Station do
      @moduledoc """
      struct of the station
      """
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
              |> List.to_string(),
              coords: coor
            }
          end)

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
         bi_station = Enum.chunk_every(line.stations, 2, 1, :discard)
         Enum.reduce(bi_station, graph, fn station, graph ->
             Graph.add_edge(graph, List.first(station).name, List.last(station).name)
         end)
       end)
    end

end
