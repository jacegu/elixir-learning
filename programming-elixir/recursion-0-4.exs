defmodule MyList do
  def sumac(list), do: _sumac(list, 0)
  defp _sumac([], ac),    do: ac
  defp _sumac([h|t], ac), do: _sumac(t, ac + h)

  def sum([]),    do: 0
  def sum([h|t]), do: h + sum(t)

  def map([], _fun),    do: []
  def map([h|t], fun), do: [fun.(h) | map(t,fun)]

  def reduce([], value, _fun),    do: value
  def reduce([h|t], value, fun),  do: reduce(t, fun.(h, value), fun)

  def mapsum([], _fun),   do: 0
  def mapsum([h|t], fun), do: fun.(h) + mapsum(t, fun)

  def max(list), do: _max(list, 0)
  defp _max([], max),                  do: max
  defp _max([h|t], max) when h >= max, do: _max(t, h)
  defp _max([h|t], max) when h <  max, do: _max(t, max)

  def max_kernel([]),    do: 0
  def max_kernel([h|t]), do: Kernel.max(h, max_kernel(t))

  def caesar([], _n),                  do: ''
  def caesar([h|t], n) when h+n <= ?z, do: [h+n | caesar(t, n)]
  def caesar([h|t], n) when h+n > ?z,  do: [rem(h+n, ?z) + ?a | caesar(t, n)]

  def span(from, to), do: _span(from, to, [])
  def _span(to, to, list), do: list ++ [to]
  def _span(from, to, list), do: _span(from + 1, to, list ++ [from])

end





