defmodule RabbitMQ.Consumer do
  @doc """
  Creates a process that listens for messages on the given queue.
  When a message arrives, it writes to the log the pid, queue_name and msg.
  Example:
    iex> {:ok, pid} = Consumer.start("orders")
  """
  use AMQP
  def start(queue_name) do
    #se crea la conexión
    {:ok, connection} = Connection.open()
    {:ok, channel} = Channel.open(connection)
    Basic.consume(channel, queue_name, nil, no_ack: true)
    IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"
    wait_for_messages(channel)

    #spawn(fn -> wait_for_messages(channel) end)

  end

  def wait_for_messages(channel) do
    receive do
      {:basic_deliver, payload, meta} ->
        IO.puts " [x] Received [#{meta.routing_key}] #{payload} #{inspect(self())}"

        wait_for_messages(channel)
    end
  end
  @doc """
  Stops the given consumer.
  Example:
    iex> Consumer.stop("orders")
  """
  def stop(pid) do
    AMQP.Connection.close(pid)
  end
end
