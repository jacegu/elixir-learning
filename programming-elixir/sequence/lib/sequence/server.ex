defmodule Sequence.Server do
  use GenServer

  def start_link(initial_number) do
    GenServer.start_link(__MODULE__, initial_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def reset_number(new_number) do
    GenServer.call(__MODULE__, {:reset_number, new_number})
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number+1}
  end

  def handle_call({:reset_number, new_number}, _from, _current_number) do
    {:reply, new_number, new_number}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

end
