defmodule HumanDate do
  use Timex
  import Times
  import Ending

  def print_date do
    "#{month_name()} " <>
      "#{today().day}-е " <>
      "#{part_of_day()} " <>
      "#{day_name()}, " <>
      "#{hour()} " <> "#{minute()} " <> "#{noon()}"
  end

  defp day_name do
    today()
    |> Timex.weekday()
    |> Timex.day_name()
    |> String.downcase()
  end

  defp today, do: Timex.today()

  defp current_time, do: Time.utc_now()

  defp month_name, do: Timex.month_name(today().month)

  defp hour do
    correct_ending(current_time().hour, "час", "часа", "часов")
  end

  defp minute do
    correct_ending(current_time().minute, "минута", "минуты", "минут")
  end

  defp noon do
    if current_time().hour > 12, do: "после полудня", else: "до полудня"
  end
end
