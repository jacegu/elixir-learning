defmodule TokenPassing do

  def start do
    echoer1 = spawn_token_echoer(self)
    echoer2 = spawn_token_echoer(self)

    send(echoer1, "betty")
    send(echoer2, "fred")

    wait_for_tokens
  end

  def wait_for_tokens do
    receive do
      token ->
        IO.puts("Received token #{token}")
        wait_for_tokens
    after
      1_000 -> IO.puts("nothing after 1s")
    end
  end

  defp spawn_token_echoer(receiver) do
    spawn(fn() ->
      receive do
        token -> send(receiver, token)
      end
    end)
  end
end
