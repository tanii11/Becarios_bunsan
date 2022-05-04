defmodule Counter do
  def count(n) do
    state = receive do
      {:count, pid} ->
        send(pid, {:state, n + 1})
        n + 1
      _ -> n
    end
    count(state)
  end
end
