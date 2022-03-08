defmodule FizzBuzz do  
  def call(y) do
    Enum.each(1..y, fn x -> f(x) end)
  end

  def f(x) do
    cond do
      rem(x, 3) == 0 && rem(x, 5) == 0 -> IO.puts("FizzBuzz")
      rem(x, 3) == 0 -> IO.puts("Fizz")
      rem(x, 5) == 0 -> IO.puts("Buzz")
      true -> IO.puts(x)
    end
  end
end

