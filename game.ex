defmodule PingPong do

  def run do
    ping_pid = spawn(PingPong, :ping, [])
    pong_pid = spawn(PingPong, :pong, [])

    send ping_pid, {:ping, pong_pid}
  end

  def ping do
    receive do
      {:ping , sender_pid} ->
        IO.puts "Ping"
        send sender_pid, {:pong, self()}
    end
    ping()
  end


  def pong do
    receive do
      {:pong , sender_pid} ->
        IO.puts "Pong"
        send sender_pid, {:ping, self()}
    end
    pong()
  end
end

PingPong.run()
