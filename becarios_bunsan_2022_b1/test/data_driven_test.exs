defmodule DataDrivenTest do
  use ExUnit.Case
  import SUT

  data = [
    {1, 3, 4},
    {7, 4, 11},
    {5, 5, 13},
    {3, 12, 15},
    # Error intencional
    {8, 8, 16}
  ]

  for {a, b, c} <- data do
    @a a
    @b b
    @c c
    test "sum of #{@a} and #{@b} should equal #{@c}" do
      assert SUT.sum(@a, @b) == @c
    end
  end
end
