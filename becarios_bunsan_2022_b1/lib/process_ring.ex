defmodule ProcessRing do
  @moduledoc """
  The following program consists of making a ring of processes in order
  to send a message between them the number of turns that the user indicates
  """
  def init(n) do
    pids = Enum.map(1..n, fn _ -> spawn(&wait_for_config/0) end)
    next_pids = Enum.drop(pids, 1) ++ [hd(pids)]
    ring_config = Enum.zip(pids, next_pids)

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
    send(pid, {msg, n, n})
  end

  defp wait_for_config() do
    receive do
      {:config, next_pid, main} ->
        IO.puts("pid: #{inspect(self())}, next: #{inspect(next_pid)} main: #{main}")
        process_msg(next_pid, main)
      _ ->
        :ok
    end
  end

  defp process_msg(next, main) do
    receive do
      {msg, n, total_rounds} ->
        rem_rounds = rem_rounds(main, n)
        case rem_rounds do
          :done -> :ok
          _ ->
            round = total_rounds - rem_rounds
            IO.puts("Process #{inspect(self())} received message \"#{msg}\", round #{round}")
            send(next, {msg, rem_rounds, total_rounds})
        end
      _ ->
        :ok
    end
    process_msg(next, main)
  end

  defp rem_rounds(main, n) do
    cond do
      main and n > 0 -> n - 1
      main -> :done
      true -> n
    end
  end
end
