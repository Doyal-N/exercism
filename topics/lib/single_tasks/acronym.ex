defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS",
  "My arm-chair bad" => "MACB",
  "Yoda stupid _hobbit_" => "YSH"
  """

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    prepare_str(string)
    |> Enum.map_join(&String.first/1)
    |> String.upcase()
  end

  defp prepare_str(str) do
    String.replace(str, ["_", "-"], " ")
    |> String.split(" ", trim: true)
  end
end
