defmodule Strings do
  def capitalize_sentences(text) do
    text
      |> String.split(~r{\.\s+})
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(". ")
  end
end
