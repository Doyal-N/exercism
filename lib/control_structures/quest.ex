defmodule Quest do
  def user_input(msg) do
    IO.gets(msg)
    |> String.trim()
    |> String.to_integer()
  end

  def play do
    IO.puts("Какое загадано число? ")
    play(rand_num())
  end

  defp rand_num, do: Enum.random(1..7)

  defp play(number) do
    user_number = user_input("Твой ответ ")

    case user_number do
      ^number ->
        IO.puts("Угадал!")

      num when num in 1..7 ->
        IO.puts("Неправильно. Попробуй еще раз!")
        play(number)

      _ ->
        IO.puts("Числа от 1 до 7")
        play(number)
    end
  end
end
