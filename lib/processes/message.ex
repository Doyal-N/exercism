defmodule Message do
  @moduledoc """
  Receive messages
  pid = spawn(Message, :count_messages, [0])
  """
  def count_messages(count) do
    receive do
      :count ->
        "Received #{count} msg"
        exit(:normal)

      msg ->
        {:ok, msg}
        timer_msg(count)
        count_messages(count + 1)
    end
  end

  defp timer_msg(count) do
    if count == 0, do: :timer.send_after(60_000, :count)
  end

  def async_time do
    1..4
    |> Task.async_stream(
      fn x ->
        :timer.sleep(2000)
        "#{x} - #{Time.utc_now()}"
      end,
      max_concurrency: 4,
      timeout: 4_000
    )
    |> Enum.each(&IO.puts/1)

    Time.utc_now()
  end
end
