defmodule Otpstack.Server do
  use GenServer

  @default_stack_name __MODULE__

  def start_link(stash, stack_name \\ @default_stack_name) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash, name: stack_name)
  end

  def push(stack_name \\ @default_stack_name, element) do
    GenServer.cast(stack_name, {:push, element})
  end

  def pop(stack_name \\ @default_stack_name) do
    GenServer.call(stack_name, :pop)
  end


  def init(stash) do
    stack = Otpstack.Stash.get_value(stash)
    {:ok, {stack, stash}}
  end

  def handle_call(:pop, _from, {stack, stash}) do
    [head | tail] = stack
    {:reply, head, {tail, stash}}
  end

  def handle_cast({:push, pushed_value}, {stack, stash})  do
    {:noreply, {[pushed_value | stack], stash}}
  end

  def terminate(reason, {stack, stash}) do
    Otpstack.Stash.set_value(stash, stack)
  end

end
