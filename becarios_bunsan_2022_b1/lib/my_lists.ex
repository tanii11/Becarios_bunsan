defmodule MyLists do
    def map([], _), do: []
    def map([h|t], fun), do: [fun.(h)| map(t,fun)]  

    def each([], _), do: :ok
    def each([h|t], fun) do
        fun.(h)
        each(t,fun)
    end

    def reduce([], a, _), do: a
    def reduce([h|t], a, fun), do: reduce(t, fun.(h, a), fun)     

    def zip([], _), do: []
    def zip(_, []), do: []
    def zip([ h1 | t1 ], [ h2 | t2 ]), do: [{ h1, h2 } | zip(t1, t2)]

    def zip_with([], _, _), do: []
    def zip_with(_, [], _), do: []
    def zip_with([ h1 | t1 ], [ h2 | t2 ], fun), do: [fun.(h1, h2) | zip_with(t1, t2, fun)]
end

#Nume.each(["some", "example"], fn x -> IO.puts(x) end)
#Nume.zip([1, 2, 3], [:a, :b, :c])
#Nume.zip_with([1, 2, 5, 6], [3, 4], fn x, y -> x + y end)