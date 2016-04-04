defmodule Processes do

  def run do
    spawn_process(self)

    :timer.sleep(500)

    receive do
      message -> IO.puts(inspect(message))
    after
      1_000 -> IO.puts("waited too long")
    end
  end

  def spawn_process(parent) do
    spawn_link(fn() -> send(parent, "I'm alive") end)
  end

end
