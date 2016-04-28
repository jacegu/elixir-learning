defmodule Otpstack do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Otpstack.Server, [])
    ]

    opts = [ strategy: :one_for_one, name: Otpstack.Supervisor ]

    {:ok, _pid} = Supervisor.start_link(children, opts)
  end

end
