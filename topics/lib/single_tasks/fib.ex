defmodule Fib do
  def calculate(n), do: do_calculate(0, 1, n)
  def do_calculate(_, result, 1), do: result
  def do_calculate(a, b, n), do: do_calculate(b, a + b, n - 1)
end
