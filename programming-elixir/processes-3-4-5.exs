defmodule Processes do

  def run do
    monitor_process_message(self)

    :timer.sleep(500)

    receive_messages
  end

  def receive_messages do
    receive do
      message -> IO.puts(inspect(message))
      receive_messages
    after
      2_000 -> IO.puts("waited too long")
    end
  end

  def message(parent) do
    send(parent, "I'm alive")
  end

  def message_and_raise(parent) do
    message(parent)
    raise "Boom"
  end

  def link_process_message(parent) do
    spawn_link(Processes, :message, [parent])
  end

  def link_process_raise(parent) do
    spawn_link(Processes, :message_and_raise, [parent])
  end

  def monitor_process_message(parent) do
    spawn_monitor(Processes, :message, [parent])
  end

  def monitor_process_raise(parent) do
    spawn_monitor(Processes, :message_and_raise, [parent])
  end

end
