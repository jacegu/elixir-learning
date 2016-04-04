defmodule MyParallel do

  def pmap(enum, fun) do
    me = self

    enum
      |> Enum.map(fn(element) ->
           spawn_link(fn() -> send(me, {self, fun.(element)}) end)
         end)
      |> Enum.map(fn(pid) ->
           receive do
             { ^pid, result_element } -> result_element
           end
         end)
  end

end
