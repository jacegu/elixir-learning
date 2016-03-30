defmodule Recursion do

  def primes(n) do
    for x <- 2..n, is_prime(x), do: x
  end

  def is_prime(1), do: true
  def is_prime(2), do: true
  def is_prime(n) do
    Enum.filter(2..n-1, &(rem(n, &1) == 0))
      |> Enum.empty?
  end

  @tax_rates [ NC: 0.075, TX: 0.08 ]
  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

  def totals(taxes \\ @tax_rates, orders \\ @orders) do
    Enum.map(orders, &(calculate_total(&1, taxes)))
  end

  def calculate_total(order = [id: _, ship_to: ship_to, net_amount: net_amount], taxes) do
    tax_rate = Keyword.get(taxes, ship_to, 0)
    taxes = tax_rate * net_amount
    total = taxes + net_amount

    Keyword.put(order, :total, total)
  end

end
