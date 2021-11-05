defmodule Server.Logic do
  def add(current_num, num), do: num + current_num

  def mult(current_num, num), do: num * current_num

  def divide(_current_num, num) when num == 0, do: {:error, :division_by_zero}
  def divide(current_num, num), do: div(current_num, num)

  def clean, do: 0
end
