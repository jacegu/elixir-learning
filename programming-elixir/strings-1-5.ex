defmodule MyString do

  def printable([]), do: true
  def printable([h | t])  when h >= ?\s and h <= ?~, do: printable(t)
  def printable(_other), do: false

  def is_printable(char_list) do
    char_list |> Enum.all?(fn(char) -> char in ?\s..?~ end)
  end

  def anagram?(string1, string2) do
    characters(string1) == characters(string2)
  end

  defp characters(string) do
    string |> String.codepoints |> Enum.sort
  end

  def calculate(operation) do
    [operand1,  rest] = extract_chunk(operation)
    [operation, rest] = extract_chunk(rest)
    [operand2, _rest] = extract_chunk(rest)

    operate(operation, to_integer(operand1), to_integer(operand2))
  end

  defp extract_chunk(operation), do: _extract_chunk(operation, [])
  defp _extract_chunk([], operand),        do: [operand, []]
  defp _extract_chunk([?\s | t], operand), do: [operand, t]
  defp _extract_chunk([h   | t], operand), do: _extract_chunk(t, operand ++ [h])

  defp to_integer(charlist), do: _to_integer(charlist, 0)
  defp _to_integer([], integer),      do: integer
  defp _to_integer([h | t], integer), do: _to_integer(t, integer*10 + char_to_int(h))

  defp char_to_int(char), do: char - ?0

  defp operate('+', operand1, operand2), do: operand1 + operand2
  defp operate('-', operand1, operand2), do: operand1 - operand2
  defp operate('*', operand1, operand2), do: operand1 * operand2
  defp operate('/', operand1, operand2), do: operand1 / operand2

  def print_centered(strings) do
    max_length     = Enum.map(strings, &(String.length/1)) |> Enum.max
    padded_strings = Enum.map(strings, &(center(&1, max_length)))

    Enum.each(padded_strings, &IO.puts/1)
  end

  def center(string, max_length) do
    string_length = String.length(string)
    total_padding = max_length - string_length
    right_padding = div(total_padding, 2) + string_length

    String.rjust(string, right_padding)
  end
end
