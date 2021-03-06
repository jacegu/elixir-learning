defmodule Sequence.SubSupervisor do
  use Supervisor

  def start_link(stash) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash)
  end

  def init(stash) do
    child_processes = [ worker(Sequence.Server, [stash]) ]
    supervise(child_processes, strategy: :one_for_one)
  end
end
