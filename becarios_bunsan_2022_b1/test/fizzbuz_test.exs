defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  test "fizz" do
    assert FizzBuzz.f(3) == IO.puts("Fizz")
  end

  test "buzz" do
    assert FizzBuzz.f(10) == IO.puts("Buzz")
  end

  test "fizzbuzz" do
    assert FizzBuzz.f(15) == IO.puts("FizzBuzz")
  end

  test "numero" do
    assert FizzBuzz.f(7) == IO.puts(7)
  end
end
