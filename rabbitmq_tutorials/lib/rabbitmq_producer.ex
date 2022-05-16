defmodule RabbitMQ.Producer do
  @doc """
  Sends n messages with payload 'msg' and the given routing key.
  """
  use AMQP
  def send(exchange, routing_key, msg, n) do

    #se crea la conexión
    {:ok, connection} = Connection.open()
    {:ok, channel} = Channel.open(connection)

    Enum.map(1..n, fn x ->
      AMQP.Basic.publish(channel, exchange, routing_key, msg)
      IO.puts " [x] Sent '#{routing_key} #{msg}'"
    end)
    
  end
end
