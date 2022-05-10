defmodule CalculatorAgent do
  @moduledoc """
  The following program consists of making a calculator with the operations
  of addition, subtraction, multiplication and division with the use of the Agent
  """
  def init() do
    {:ok, pid} = Agent.start(fn -> 0 end)
    pid
  end

  def sum(pid, val) do
    Agent.update(pid, fn p -> p + val end)
  end

  def sub(pid, val) do
    Agent.update(pid, fn p -> p - val end)
  end
  def mult(pid, val) do
    Agent.update(pid, fn p -> p * val end)
  end
  def div(pid, val) do
    Agent.update(pid, fn p -> p / val end)
  end

  def state(pid) do
    Agent.get(pid, & &1)
  end
end
