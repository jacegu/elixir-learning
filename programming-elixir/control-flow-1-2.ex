defmodule Fizzbuzz do

  def for_a(n) when rem(n, 15) == 0, do: "FizzBuzz"
  def for_a(n) when rem(n, 3)  == 0, do: "Fizz"
  def for_a(n) when rem(n, 5)  == 0, do: "Buzz"
  def for_a(n),                      do: n

  def for_b(n) do
    case { divisible(n, 3), divisible(n, 5) } do
      { true,  true  } -> "FizzBuzz"
      { true,  false } -> "Fizz"
      { false, true  } -> "Buzz"
      { false, false } -> n
    end
  end

  defp divisible(n, divisor), do: rem(n, divisor) == 0

end
