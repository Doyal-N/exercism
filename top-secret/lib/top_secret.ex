defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({fun, _, [{:when, _, [{name, _, ary}, _]}, _]} = ast, acc)
      when fun in [:def, :defp] do
    {ast, [top_str(name, ary) | acc]}
  end

  def decode_secret_message_part({fun, _, [{name, _, ary}, _]} = ast, acc)
      when fun in [:def, :defp] do
    {ast, [top_str(name, ary) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_, secret} = Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2)
    Enum.reverse(secret) |> to_string()
  end

  defp top_str(_, []), do: ""
  defp top_str(_, nil), do: ""
  defp top_str(name, ary), do: String.slice(to_string(name), 0, length(ary))
end
