
defmodule Calculator do
  def init(n) do
    state = receive do
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
      _ -> IO.puts("invalid operation")
    end
    init(state)
  end
end
