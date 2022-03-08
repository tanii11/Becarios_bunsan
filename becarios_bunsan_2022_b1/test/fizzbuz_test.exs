defmodule FizzBuzzTest do
    use ExUnit.Case
    doctest FizzBuzz
  
    test "fizzbuzz" do
      assert FizzBuzz.call(15) == :ok
    end
  end
  