defmodule Bob do
  @non_letters ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ")"]

  @spec hey(String.t()) :: String.t()
  def hey(input), do: check_input(input)

  defp check_input(input) do
    cond do
      blank?(input) -> "Fine. Be that way!"
      only_numbers?(input) -> "Whatever."
      numbers?(input) && question?(input) -> "Sure."
      upcase?(input) && question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      upcase?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp blank?(input), do: String.trim(input) == ""

  defp upcase?(input), do: String.upcase(input) == input

  defp numbers?(input), do: String.contains?(input, @non_letters)

  defp question?(input), do: String.trim(input) |> String.ends_with?("?")

  defp only_numbers?(input), do: input =~ ~r/^[\d ,]+$/
end
