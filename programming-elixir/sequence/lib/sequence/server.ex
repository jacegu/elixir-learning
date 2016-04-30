defmodule Sequence.Server do
  use GenServer

  def start_link(stash) do
    GenServer.start_link(__MODULE__, stash, name: __MODULE__)
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


  def init(stash) do
    current_number = Sequence.Stash.get_value(stash)
    { :ok, {current_number, stash} }
  end

  def handle_call(:next_number, _from, {current_number, stash}) do
    {:reply, current_number, {current_number+1, stash}}
  end

  def handle_call({:reset_number, new_number}, _from, {_current_number, stash}) do
    {:reply, new_number, {new_number, stash}}
  end

  def handle_cast({:increment_number, delta}, {current_number, stash}) do
    {:noreply, {current_number + delta, stash}}
  end

  def terminate(_reason, {current_number, stash}) do
    Sequence.Stash.save_value(stash, current_number)
  end

end
