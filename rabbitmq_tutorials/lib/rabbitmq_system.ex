defmodule RabbitMQ.System do
  @doc """
  Creates the exchaange, the queues and their bindings.
  If the exchange and queues already exist, does nothing.
  """
  use AMQP

  def setup(exchange_name, queue_names) do
    #se crea la conexión
    {:ok, connection} = Connection.open()
    {:ok, channel} = Channel.open(connection)
    #se crea el intercambio
    Exchange.declare(channel, exchange_name, :direct)
    #se crean las colas y enlaces
    queue_names
    |> Enum.map(fn queue ->
      Queue.declare(channel, queue)
      Queue.bind(channel, queue, exchange_name, routing_key: queue)
    end)

  end
end
