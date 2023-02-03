defmodule Times do
  @moduledoc """
  Define time
  """
  def part_of_day do
    time = Time.utc_now()

    case time.hour do
      h when h in 5..9 -> "утро"
      h when h in 10..18 -> "день"
      h when h in 19..23 -> "вечер"
      _ -> "ночь"
    end
  end
end
