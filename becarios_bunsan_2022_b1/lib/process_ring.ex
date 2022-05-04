defmodule ProcessRing do
  def init(n) do
    1..n |> Enum.map(fn x ->
      spawn(ProcessRing, :message, [])
    end)
  end

  def message do
    receive do
      {who, pid} -> send(pid, "Hello #{who} from #{inspect(self())}")
      _ -> IO.puts("uh??")
    end
  end
end
