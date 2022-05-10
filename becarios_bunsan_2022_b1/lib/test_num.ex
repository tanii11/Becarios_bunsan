defmodule TestNum do
@moduledoc """
The following program consists of validating if a number is positive, negative or zero
"""
    def test(x) when is_number(x) and x < 0  do
      :negative
    end

    def test(0) do
      :zero
    end

    def test(x) when is_number(x) and  x > 0 do
      :positive
    end
  end
