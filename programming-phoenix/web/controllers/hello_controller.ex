defmodule ProgrammingPhoenix.HelloController do
  use ProgrammingPhoenix.Web, :controller

  def hello(conn, %{"name" => name}) do
    render conn, "index.html", name: name
  end
end
