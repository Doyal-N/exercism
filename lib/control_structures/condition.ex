defmodule Condition do
  def more_num(a, a), do: "Равно"

  def more_num(a, b) do
    if a > b, do: "Больше", else: "Меньше"
  end

  def more_number(a, b) do
    cond do
      a > b -> "Больше"
      a < b -> "Меньше"
      true -> "Равно"
    end
  end

  def small_number(a, b) do
    case a do
      a when a > b -> "Больше"
      a when a < b -> "Меньше"
      _ -> "Равно"
    end
  end
end
