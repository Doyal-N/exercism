defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  # def flatten(list), do: do_flatten(list)

  # defp do_flatten([], new_list), do: new_list
  # defp do_flatten([h | t], new_list) when is_nil(h), do: do_flatten(t, new_list)
  # defp do_flatten([h | t], new_list) when is_list(h), do: do_flatten(h, do_flatten(t, new_list))
  # defp do_flatten([h | t], new_list), do: [h | do_flatten(t, new_list)]

  def flatten([]), do: []
  def flatten(nil), do: []
  def flatten([xh | xt]), do: flatten(xh) ++ flatten(xt)
  def flatten(x), do: [x]
end
