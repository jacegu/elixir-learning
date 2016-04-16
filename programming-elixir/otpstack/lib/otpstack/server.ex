defmodule Otpstack.Server do
  use GenServer

  def start_link(stack_name) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, _empty_stack = [], name: stack_name)
  end

  def push(stack_name, :halt),   do: System.halt(0)
  def push(stack_name, element), do: GenServer.cast(stack_name, {:push, element})

  def pop(stack_name) do
    GenServer.call(stack_name, :pop)
  end

  def handle_call(:pop, _from, current_state) do
    [head | tail] = current_state
    {:reply, head, tail}
  end

  def handle_cast({:push, pushed_value}, current_state)  do
    {:noreply, [pushed_value | current_state]}
  end

  def terminate(reason, current_state) do
    IO.inspect(reason)
    IO.puts("Current state: #{inspect(current_state)}")
  end
end
