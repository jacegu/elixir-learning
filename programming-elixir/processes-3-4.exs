defmodule Processes do

  def run do
    spawn_process_raise(self)

    :timer.sleep(500)

    receive do
      message -> IO.puts(inspect(message))
    after
      1_000 -> IO.puts("waited too long")
    end
  end

  def spawn_process_message(parent) do
    spawn_link(fn() -> send(parent, "I'm alive") end)
  end

  def spawn_process_raise(parent) do
    spawn_link(fn() ->
      send(parent, "I'm alive")
      raise "Boom"
    end)
  end

end
