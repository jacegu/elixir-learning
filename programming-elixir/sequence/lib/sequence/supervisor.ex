defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, pid} = Supervisor.start_link(__MODULE__, [initial_number])
    start_workers(pid, initial_number)
    result
  end

  def start_workers(supervisor, initial_number) do
    {:ok, stash} = Supervisor.start_child(supervisor, worker(Sequence.Stash, [initial_number]))
    {:ok, _subsupervisor} = Supervisor.start_child(supervisor, worker(Sequence.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
