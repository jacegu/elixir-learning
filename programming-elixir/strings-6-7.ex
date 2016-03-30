defmodule Strings do
  def capitalize_sentences(text) do
    text
      |> String.split(~r{\.\s+})
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(". ")
  end

  def parse_orders(path \\ "strings-7-orders.csv") do
   [header_row | other_rows] = lines(path)
   names  = field_names(header_row)
   values = field_values(other_rows)
   Enum.map(values, &(Enum.zip(names, &1)))
  end

  defp lines(path) do
    path
      |> File.read!
      |> String.split("\n")
  end

  defp field_names(header_row) do
    header_row
      |> String.split(",")
      |> Enum.map(&(String.to_atom/1))
  end

  defp field_values(other_rows) do
    other_rows
      |> Enum.filter(&(String.strip(&1) != ""))
      |> Enum.map(&(String.split(&1, ",")))
      |> Enum.map(&(parse_values/1))
  end

  defp parse_values([id, ship_to, net_amount]) do
    [parse_id(id), parse_ship_to(ship_to), parse_net_amount(net_amount) ]
  end

  defp parse_id(id), do: String.to_integer(id)
  defp parse_ship_to(ship_to), do: ship_to |> String.replace(~r{^:}, "") |> String.to_atom
  defp parse_net_amount(net_amount), do: String.to_float(net_amount)
end
