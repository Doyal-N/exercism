defmodule CustomSet do
  defstruct map: %{}
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enum) do
    set = Enum.reduce(enum, %{}, &Map.put(&2, &1, nil))
    %__MODULE__{map: set}
  end

  @spec empty?(t) :: boolean
  def empty?(set), do: map_size(set.map) == 0

  @spec contains?(t, any) :: boolean
  def contains?(set, element), do: Map.has_key?(set.map, element)

  @spec subset?(t, t) :: boolean
  def subset?(%__MODULE__{map: set_1}, %__MODULE__{map: set_2}) do
    Map.keys(set_1)
    |> Enum.all?(&Map.has_key?(set_2, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%__MODULE__{map: set_1}, %__MODULE__{map: set_2}) do
    Map.keys(set_1)
    |> Enum.all?(fn elem -> !Map.has_key?(set_2, elem) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(%__MODULE__{map: set_1}, %__MODULE__{map: set_2}), do: set_1 === set_2

  @spec add(t, any) :: t
  def add(%__MODULE__{map: set}, elem), do: %__MODULE__{map: Map.put(set, elem, nil)}

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{map: set_1}, %__MODULE__{map: set_2}) do
    Map.keys(set_1)
    |> Enum.filter(&Map.has_key?(set_2, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%__MODULE__{map: set_1}, %__MODULE__{map: set_2}) do
    Map.keys(set_1)
    |> Enum.filter(fn elem -> !Map.has_key?(set_2, elem) end)
    |> new()
  end

  @spec union(t, t) :: t
  def union(set1, set2), do: %__MODULE__{map: Map.merge(set1.map, set2.map)}
end
