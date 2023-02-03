defmodule Collections do
  @moduledoc """
    Transform collections
  """
  def transform_list_with_enum(list) do
    list
    |> Enum.map(&(&1 * 2))
    |> Enum.reject(&(rem(&1, 10) == 0))
  end

  def transform_list_with_for(list) do
    for el <- list, el = el * 2, rem(el, 10) != 0, do: el
  end

  def transform_list_with_stream(list) do
    list
    |> Stream.map(&(&1 * 2))
    |> Stream.filter(&(rem(&1, 10) != 0))
    |> Enum.to_list()
  end

  def change_key_value(map) do
    for {key, val} <- map, into: %{}, do: {val, key}
  end

  def custom_group_by(list, fun_for_key, fun_for_value \\ fn el -> el end) do
    Enum.reduce(list, %{}, fn el, acc ->
      key = fun_for_key.(el)
      value = fun_for_value.(el)

      case acc do
        %{^key => values} -> Map.put(acc, key, [value | values])
        %{} -> Map.put(acc, key, [value])
      end
    end)
  end

  def fibonachi, do: Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
end
