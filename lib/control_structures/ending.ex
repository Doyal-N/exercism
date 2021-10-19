defmodule Ending do
  def correct_ending(number, one, few, many) do
    last_num = rem(number, 10)
    last_num2 = rem(number, 100)

    cond do
      last_num2 in 11..14 -> "#{number} #{many}"
      last_num == 1 -> "#{number} #{one}"
      last_num in 2..4 -> "#{number} #{few}"
      true -> "#{number} #{many}"
    end
  end
end
