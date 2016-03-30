defmodule MyEnum do

  def all?(enumerable, predicate), do: _all?(enumerable, predicate, true)
  def _all?([], _predicate, value),     do: value
  def _all?([h | t], predicate, value), do: _all?(t, predicate, value and predicate.(h))


  def each([],   _fun), do: :ok
  def each([h|t], fun) do
    fun.(h)
    each(t, fun)
  end


  def filter(enumerable, predicate), do: _filter(enumerable, predicate, [])
  def _filter([], _predicate, filtered), do: filtered
  def _filter([h | t], predicate, filtered) do
    if predicate.(h) do
      _filter(t, predicate, filtered ++ [h])
    else
      _filter(t, predicate, filtered)
    end
  end


  def split(enumerable, size) when size >= 0 do
    [h,t] = _split(enumerable, size, [])
    {h,t}
  end
  def split(enumerable, size) when size < 0 do
    chunks = _split(reverse(enumerable), abs(size), [])
    [h,t] = map(chunks, &reverse/1)
    {t,h}
  end
  def _split([], _size, slice),                                   do: [slice, []]
  def _split(enumerable, size, slice) when length(slice) >= size, do: [slice, enumerable]
  def _split([h | t], size, slice)    when length(slice) < size,  do: _split(t, size,  slice ++ [h])


  def reverse(enumerable), do: _reverse(enumerable, [])
  defp _reverse([], reversed),      do: reversed
  defp _reverse([h | t], reversed), do: _reverse(t, [h | reversed])


  def map(enumerable, fun), do: _map(enumerable, fun, [])
  def _map([], _fun, mapped), do: mapped
  def _map([h | t], fun, mapped), do: _map(t, fun, mapped ++ [fun.(h)])


  def take(enumerable, n), do: _take(enumerable, n, [])
  defp _take(_enumerable, n, taken) when length(taken) >= n, do: taken
  defp _take([h | t], n, taken)     when length(taken) < n,  do: _take(t, n, taken ++ [h])


  def flatten(enumerable), do: _flatten(enumerable, [])
  def _flatten([], flattened),      do: flattened
  def _flatten([h | t], flattened), do: _flatten(t,  flattened ++ _flatten(h, []))
  def _flatten(element, flattened), do: flattened ++ [element]
end
