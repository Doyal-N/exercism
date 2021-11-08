defmodule Server.Logic do
  def add(current_num, num) when is_integer(num) and is_integer(current_num) do
    {:ok, num + current_num}
  end

  def add(_, _), do: {:error, "invalid param"}

  def mult(current_num, num) when is_integer(num) and is_integer(current_num) do
    {:ok, num * current_num}
  end

  def mult(_, _), do: {:error, "invalid param"}

  def divide(_, 0), do: {:error, :division_by_zero}

  def divide(current_num, num) when is_integer(num) and is_integer(current_num) do
    {:ok, div(current_num, num)}
  end

  def divide(_, _), do: {:error, "invalid param"}

  def clean, do: 0
end
