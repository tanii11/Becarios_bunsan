defmodule ProcessRing do
  def init(n) do
    pids = Enum.map(1..n, fn _ -> spawn(&wait_for_config/0) end)
    next_pids = Enum.drop(pids, 1) ++ [hd(pids)]
    ring_config = Enum.zip(pids, next_pids)

    IO.inspect(ring_config)

    ring_config
    |> hd()
    |> then(fn {pid, next} -> send(pid, {:config, next, true}) end)

    ring_config
    |> Enum.drop(1)
    |> Enum.each(fn {pid, next_pid} ->
      send(pid, {:config, next_pid, false})
    end)

    hd(pids)
  end

  def rounds(pid, msg, n) do
    send(pid, {msg, n})
  end

  # funcion para crear el proceso sin parametros
  def wait_for_config() do
    receive do
      {:config, next_pid, main} ->
        IO.puts("pid: #{inspect(self())}, next: #{inspect(next_pid)} main: #{main}")
        pid0 = if(main == true) do
                 self()
               end
        process_msg(next_pid, main, pid0)
      _ -> :ok
    end
  end

  def process_msg(next, main, pid0) do
    receive do
      {msg, n} ->
        IO.puts("Process #{inspect(self())} received message \"#{msg}\", round #{n}")
        cond do

          main and n > 0 ->
            IO.inspect(pid0)
            send(next, {msg, n-1})
          main -> :ok
          true -> send(next, {msg, n})
              # cond do
              #   next == pid0 -> send(next, {msg, n-1})
              #   true -> send(next, {msg, n})
              # end
        end
      _ -> :ok
    end
    process_msg(next, main, pid0)
  end
end
