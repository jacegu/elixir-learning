defmodule Chop do
  def guess(n, low..high) do
    current_guess = middle(low..high)
    IO.puts "Is it #{current_guess}? (#{inspect(low..high)})"
    _guess(n, current_guess, low..high)
  end

  defp _guess(n, pivot, low.._)  when n < pivot, do: guess(n, low..pivot)
  defp _guess(n, pivot, _..high) when n > pivot, do: guess(n, pivot..high)
  defp _guess(n, n, _),                          do: IO.puts "It is #{n}"

  defp middle(low..high), do: div(low + high,  2)
end
