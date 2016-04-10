
defmodule Scheduler do

  def run(concurrency, module, function, args, to_calculate) do
    spawn_processes(concurrency, module ,function, args)
      |> schedule_processes([], to_calculate)
  end

  defp spawn_processes(concurrency, module, function, args) do
    Enum.map(1..concurrency, fn(_) -> spawn_process(module, function, args) end)
  end

  defp spawn_process(module, function, args) do
    spawn(module, function, args)
  end

  defp schedule_processes(processes, result, to_calculate) do
    receive do
      {:ready, sender} when length(to_calculate) > 0 ->
        [head | tail] = to_calculate
        send(sender, {:work, head, self})
        schedule_processes(processes, result, tail)

      {:ready, sender} ->
        send(sender, {:shutdown, self})
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, sender), result, to_calculate)
        else
          Enum.sort(result, fn({n1,_}, {n2,_}) -> n1 <= n2 end)
        end

      {:answer, work, answer, _sender} ->
        schedule_processes(processes, [{work, answer} | result], to_calculate)
    end
  end

end

defmodule CatCounter do

  def wait_for_work(scheduler) do
    send(scheduler, {:ready, self})

    receive do
      {:work, to_calculate, sender} ->
        send(sender, {:answer, to_calculate, word_count(to_calculate, "do"), self})
        wait_for_work(sender)

      {:shutdown, _sender} ->
        exit(:normal)
    end
  end

  defp word_count(path, counted_word) do
    File.read!(path)
      |> String.split(~r{\s})
      |> Enum.count(fn(word) -> word == counted_word end)
  end
end


files_in_path = fn(path) ->
  path
    |> File.ls!
    |> Enum.filter(&(String.match?(&1, ~r{[\.rb]$})))
    |> Enum.map(&(Path.join(path, &1)))
end


Enum.each(1..10, fn(num_processes) ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, CatCounter, :wait_for_work, [self], files_in_path.("/Users/jacegu/Downloads/filez/")])

  if num_processes == 1 do
    IO.inspect(result)
    IO.puts "\n #  time(s)"
  end

  :io.format("~2B  ~.2f~n", [num_processes, time/1_000_000.0])
end)
