defmodule MyListsTest do
    use ExUnit.Case
    doctest MyLists
  
    test "list_map" do
      assert MyLists.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
    end
    test "list_each" do
        assert MyLists.each(["alo", "policia"], fn x -> IO.puts(x) end) == :ok
    end
    test "list_reduce" do
        assert MyLists.reduce([1, 2, 3], 0, fn x, acc -> x + acc end) == 6
    end
    test "list_zip" do
        assert MyLists.zip([1, 2, 3], [:a, :b, :c]) == [{1, :a}, {2, :b}, {3, :c}]
    end
    test "list_zip_with" do
        assert MyLists.zip_with([1, 2, 5, 6], [3, 4], fn x, y -> x + y end) == [4, 6]
    end
  end
  #Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
  
#Nume.each(["some", "example"], fn x -> IO.puts(x) end)
#Nume.zip([1, 2, 3], [:a, :b, :c])
#Nume.zip_with([1, 2, 5, 6], [3, 4], fn x, y -> x + y end)