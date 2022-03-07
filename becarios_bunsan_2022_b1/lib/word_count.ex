defmodule WordCount do 
    def count (path) do
        {:ok, doc} = File.read(path)
        doc = String.downcase(doc)
        doc1 = String.split(doc, [",",";",":",".","_","-","|","°","#","$","%","&","/","(",")","()","{}","=","+","*",">","<","[","]","\r","?","¿", "!","¡"]) |> List.to_string()
        doc2 = String.split(doc1)
        mapa = Enum.map(doc2, fn x -> 
            cont = Enum.count(doc2, fn s -> 
                s == x
            end)
            Map.put(%{}, x, cont)
        end)
        Enum.reduce(mapa, %{}, fn (x, acc) -> 
            Map.merge(acc, x) 
        end)
    end
end

