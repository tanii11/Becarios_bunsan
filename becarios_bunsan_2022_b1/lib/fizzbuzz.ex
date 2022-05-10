defmodule FizzBuzz do
  @moduledoc """
  The following program consists of making a program where the user indicates a limit number
  and the program will print the series on the screen, taking into account that:
  if the number is a multiple of 3 the program will print Fizz
  if the number is a multiple of 5 the program will print Buzz
  if the number is a multiple of 3 and 5 the program will print FizzBuzz
  """
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
