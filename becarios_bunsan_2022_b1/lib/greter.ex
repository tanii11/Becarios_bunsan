defmodule Greeter do
@moduledoc """
The following program consists of a function greet with the use of processes
"""
  def greet() do
    receive do
      {who, pid} -> send(pid, "Hello #{who} from #{inspect(self())}")
      _ -> IO.puts("uh??")
    end
    greet()
  end
end
