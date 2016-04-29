defmodule ProgrammingPhoenix.HelloController do
  use ProgrammingPhoenix.Web, :controller

  def hello(conn, _params) do
    render conn, "index.html"
  end
end
