defmodule Otpstack do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = Otpstack.Supervisor.start_link([:bottom])
  end

end
