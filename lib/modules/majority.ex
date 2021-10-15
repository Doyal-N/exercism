defmodule Majority do
  @moduledoc """
  Module defines adult person
  """

  def user_adult?(age), do: adult?(age)
  defp adult?(age) when is_integer(age) and age >= 18, do: true
  defp adult?(age) when is_integer(age), do: false
end
