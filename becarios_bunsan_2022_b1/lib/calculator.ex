defmodule Calculator do
  @moduledoc """
  The following program consists of making a calculator with the operations
  of addition, subtraction, multiplication and division
  with the use of the processes by sending and receiving emails.
  """
  def init(n) do
    state =
      receive do
        {:sum, cant, pid} ->
          send(pid, {:state, n + cant})
          n + cant

        {:sub, cant, pid} ->
          send(pid, {:state, n - cant})
          n - cant

        {:mult, cant, pid} ->
          send(pid, {:state, n * cant})
          n * cant

        {:div, cant, pid} ->
          send(pid, {:state, n / cant})
          n / cant

        _ ->
          IO.puts("invalid operation")
      end

    init(state)
  end
end
