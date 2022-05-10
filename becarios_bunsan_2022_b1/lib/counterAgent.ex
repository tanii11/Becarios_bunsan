defmodule CounterAgent do
  @moduledoc """
  The following program consists of making a counter using recursion and processes
  """
  use Agent

  def start(init_val) do
    Agent.start(fn -> init_val end)
  end

  def value(pid) do
    Agent.get(pid, & &1)
  end

  def inc(pid) do
    Agent.update(pid, &(&1 + 1))
  end
end
