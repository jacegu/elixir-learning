defmodule Otpstack.Supervisor do
  use Supervisor

  def start_link(initial_stack) do
    result = {:ok, pid} = Supervisor.start_link(__MODULE__, [initial_stack], name: __MODULE__)
    start_workers(pid, initial_stack)
    result
  end

  def start_workers(supervisor, initial_stack) do
    {:ok, stash}   = Supervisor.start_child(supervisor, worker(Otpstack.Stash, [initial_stack]))
    {:ok, _server} = Supervisor.start_child(supervisor, worker(Otpstack.ServerSupervisor, [stash]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
